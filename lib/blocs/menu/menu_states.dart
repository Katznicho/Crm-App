class MenuStates {
  final List<dynamic>? resources;
  final List<dynamic>? types;
  final bool isLoading;
  final bool isSuccess;
  final bool isError;
  final String? errorMessage;

  MenuStates({
    this.resources,
    this.types,
    this.isLoading = false,
    this.isSuccess = false,
    this.isError = false,
    this.errorMessage,
  });

  MenuStates copyWith({
    List<dynamic>? resources,
    List<dynamic>? types,
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    String? errorMessage,
  }) {
    return MenuStates(
      resources: resources ?? this.resources,
      types: types ?? this.types,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class MenuItemsLoading extends MenuStates {
  MenuItemsLoading({required bool isLoading}) : super(isLoading: isLoading);
}

class MenuItems extends MenuStates {
  MenuItems({required List<dynamic> resources, required List<dynamic> types})
      : super(resources: resources, types: types);
}

class MenuItemsSuccess extends MenuStates {
  MenuItemsSuccess(
      {required List<dynamic> resources, required List<dynamic> types})
      : super(
            isSuccess: true,
            isLoading: false,
            isError: false,
            resources: resources,
            types: types);
}

class MenuItemsFailure extends MenuStates {
  MenuItemsFailure({
    required String errorMessage,
  }) : super(isError: true, errorMessage: errorMessage, isLoading: false);
}
