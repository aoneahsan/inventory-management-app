import 'package:flutter/material.dart';
import 'dart:async';

/// Advanced search bar with filters
class InventorySearchBar extends StatefulWidget {
  final Function(String) onSearch;
  final Function(Map<String, dynamic>)? onFiltersChanged;
  final String hintText;
  final bool showFilters;
  final List<SearchFilter>? filters;
  final Duration debounceTime;

  const InventorySearchBar({
    Key? key,
    required this.onSearch,
    this.onFiltersChanged,
    this.hintText = 'Search...',
    this.showFilters = true,
    this.filters,
    this.debounceTime = const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  State<InventorySearchBar> createState() => _InventorySearchBarState();
}

class _InventorySearchBarState extends State<InventorySearchBar> {
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();
  Timer? _debounce;
  Map<String, dynamic> _activeFilters = {};
  bool _showFilterChips = false;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(widget.debounceTime, () {
      widget.onSearch(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  focusNode: _focusNode,
                  onChanged: _onSearchChanged,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    prefixIcon: Icon(
                      Icons.search,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              widget.onSearch('');
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
              if (widget.showFilters && widget.filters != null) ...[
                Container(
                  width: 1,
                  height: 30,
                  color: theme.colorScheme.outlineVariant,
                ),
                IconButton(
                  icon: Icon(
                    _showFilterChips
                        ? Icons.filter_list_off
                        : Icons.filter_list,
                    color: _activeFilters.isNotEmpty
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurfaceVariant,
                  ),
                  onPressed: () {
                    setState(() {
                      _showFilterChips = !_showFilterChips;
                    });
                  },
                ),
              ],
            ],
          ),
        ),
        if (_showFilterChips && widget.filters != null) ...[
          const SizedBox(height: 8),
          _buildFilterChips(theme),
        ],
        if (_activeFilters.isNotEmpty && !_showFilterChips) ...[
          const SizedBox(height: 8),
          _buildActiveFilterBadge(theme),
        ],
      ],
    );
  }

  Widget _buildFilterChips(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filters',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.filters!.map((filter) {
              final isActive = _activeFilters.containsKey(filter.key);
              
              return FilterChip(
                label: Text(filter.label),
                selected: isActive,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _showFilterDialog(filter);
                    } else {
                      _activeFilters.remove(filter.key);
                      widget.onFiltersChanged?.call(_activeFilters);
                    }
                  });
                },
                avatar: Icon(
                  filter.icon,
                  size: 18,
                ),
              );
            }).toList(),
          ),
          if (_activeFilters.isNotEmpty) ...[
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () {
                setState(() {
                  _activeFilters.clear();
                  widget.onFiltersChanged?.call(_activeFilters);
                });
              },
              icon: const Icon(Icons.clear_all, size: 18),
              label: const Text('Clear all filters'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActiveFilterBadge(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.filter_alt,
            size: 16,
            color: theme.colorScheme.onPrimaryContainer,
          ),
          const SizedBox(width: 4),
          Text(
            '${_activeFilters.length} filters active',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(SearchFilter filter) {
    showDialog(
      context: context,
      builder: (context) => FilterDialog(
        filter: filter,
        currentValue: _activeFilters[filter.key],
        onApply: (value) {
          setState(() {
            if (value != null) {
              _activeFilters[filter.key] = value;
            } else {
              _activeFilters.remove(filter.key);
            }
            widget.onFiltersChanged?.call(_activeFilters);
          });
        },
      ),
    );
  }
}

/// Search filter configuration
class SearchFilter {
  final String key;
  final String label;
  final IconData icon;
  final FilterType type;
  final dynamic options;

  SearchFilter({
    required this.key,
    required this.label,
    required this.icon,
    required this.type,
    this.options,
  });
}

enum FilterType {
  select,
  multiSelect,
  range,
  date,
  boolean,
}

/// Filter dialog for applying filters
class FilterDialog extends StatefulWidget {
  final SearchFilter filter;
  final dynamic currentValue;
  final Function(dynamic) onApply;

  const FilterDialog({
    Key? key,
    required this.filter,
    this.currentValue,
    required this.onApply,
  }) : super(key: key);

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  late dynamic _value;

  @override
  void initState() {
    super.initState();
    _value = widget.currentValue;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(widget.filter.icon),
          const SizedBox(width: 8),
          Text(widget.filter.label),
        ],
      ),
      content: _buildFilterContent(),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        if (_value != null)
          TextButton(
            onPressed: () {
              widget.onApply(null);
              Navigator.of(context).pop();
            },
            child: const Text('Clear'),
          ),
        FilledButton(
          onPressed: () {
            widget.onApply(_value);
            Navigator.of(context).pop();
          },
          child: const Text('Apply'),
        ),
      ],
    );
  }

  Widget _buildFilterContent() {
    switch (widget.filter.type) {
      case FilterType.select:
        return _buildSelectFilter();
      case FilterType.multiSelect:
        return _buildMultiSelectFilter();
      case FilterType.range:
        return _buildRangeFilter();
      case FilterType.date:
        return _buildDateFilter();
      case FilterType.boolean:
        return _buildBooleanFilter();
    }
  }

  Widget _buildSelectFilter() {
    final options = widget.filter.options as List<FilterOption>;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: options.map((option) {
        return RadioListTile<String>(
          title: Text(option.label),
          value: option.value,
          groupValue: _value,
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildMultiSelectFilter() {
    final options = widget.filter.options as List<FilterOption>;
    final selectedValues = (_value as List<String>?) ?? [];
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: options.map((option) {
        return CheckboxListTile(
          title: Text(option.label),
          value: selectedValues.contains(option.value),
          onChanged: (checked) {
            setState(() {
              if (checked == true) {
                selectedValues.add(option.value);
              } else {
                selectedValues.remove(option.value);
              }
              _value = selectedValues.isNotEmpty ? selectedValues : null;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildRangeFilter() {
    final range = (_value as RangeValues?) ?? const RangeValues(0, 100);
    final min = widget.filter.options['min'] as double? ?? 0;
    final max = widget.filter.options['max'] as double? ?? 100;
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RangeSlider(
          values: range,
          min: min,
          max: max,
          divisions: 20,
          labels: RangeLabels(
            range.start.toStringAsFixed(0),
            range.end.toStringAsFixed(0),
          ),
          onChanged: (values) {
            setState(() {
              _value = values;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Min: ${range.start.toStringAsFixed(0)}'),
            Text('Max: ${range.end.toStringAsFixed(0)}'),
          ],
        ),
      ],
    );
  }

  Widget _buildDateFilter() {
    return TextButton.icon(
      icon: const Icon(Icons.calendar_today),
      label: Text(
        _value != null
            ? '${_value.toString().split(' ')[0]}'
            : 'Select date',
      ),
      onPressed: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: _value ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (date != null) {
          setState(() {
            _value = date;
          });
        }
      },
    );
  }

  Widget _buildBooleanFilter() {
    return SwitchListTile(
      title: Text(widget.filter.label),
      value: _value ?? false,
      onChanged: (value) {
        setState(() {
          _value = value;
        });
      },
    );
  }
}

class FilterOption {
  final String label;
  final String value;

  FilterOption({
    required this.label,
    required this.value,
  });
}