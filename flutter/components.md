# iOS 26 Component Mapping for Flutter

Maps iOS 26 design system components to Flutter widgets with implementation examples.

---

## Navigation Components

### Toolbar (Top Navigation Bar)

**iOS 26**: Toolbar - Top - iPhone with Large Title or Body title.
**Flutter**: `CupertinoNavigationBar` or custom `LiquidGlassNavBar`.

#### Standard Navigation Bar

```dart
CupertinoNavigationBar(
  middle: Text('Settings'),
  leading: CupertinoNavigationBarBackButton(),
  trailing: CupertinoButton(
    padding: EdgeInsets.zero,
    child: Icon(CupertinoIcons.ellipsis),
    onPressed: () {},
  ),
  backgroundColor: IOS26Colors.backgroundPrimary,
  border: null, // iOS 26 removes bottom border
)
```

#### Large Title Navigation Bar

```dart
CupertinoSliverNavigationBar(
  largeTitle: Text('Settings'),
  trailing: CupertinoButton(
    padding: EdgeInsets.zero,
    child: Icon(CupertinoIcons.add),
    onPressed: () {},
  ),
  backgroundColor: IOS26Colors.backgroundGroupedPrimary,
  border: null,
)
```

#### Liquid Glass Floating Toolbar (iOS 26 new)

```dart
LiquidGlassNavBar(
  leading: GestureDetector(
    onTap: () => Navigator.pop(context),
    child: Icon(CupertinoIcons.back, color: IOS26Colors.blue),
  ),
  title: Text(
    'Details',
    style: IOS26Typography.headline,
  ),
  trailing: Icon(CupertinoIcons.share, color: IOS26Colors.blue),
  size: LiquidGlassSize.large,
)
```

---

### Tab Bar

**iOS 26**: Floating Liquid Glass pill tab bar at the bottom.
**Flutter**: `CupertinoTabBar` or custom `LiquidGlassTabItem` row.

#### Standard Cupertino Tab Bar

```dart
CupertinoTabScaffold(
  tabBar: CupertinoTabBar(
    activeColor: IOS26Colors.blue,
    inactiveColor: IOS26Colors.gray,
    backgroundColor: IOS26Colors.backgroundPrimary.withValues(alpha: 0.94),
    items: const [
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.house_fill),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search),
        label: 'Search',
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.person_fill),
        label: 'Profile',
      ),
    ],
  ),
  tabBuilder: (context, index) => CupertinoTabView(
    builder: (context) => pages[index],
  ),
)
```

#### Liquid Glass Tab Bar (iOS 26 new)

```dart
Container(
  padding: const EdgeInsets.symmetric(vertical: 8),
  child: SafeArea(
    top: false,
    child: LiquidGlass(
      size: LiquidGlassSize.medium,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      borderRadius: BorderRadius.circular(24),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LiquidGlassTabItem(
            icon: CupertinoIcons.house_fill,
            label: 'Home',
            isSelected: currentIndex == 0,
            onTap: () => setState(() => currentIndex = 0),
          ),
          LiquidGlassTabItem(
            icon: CupertinoIcons.search,
            label: 'Search',
            isSelected: currentIndex == 1,
            onTap: () => setState(() => currentIndex = 1),
          ),
          LiquidGlassTabItem(
            icon: CupertinoIcons.person_fill,
            label: 'Profile',
            isSelected: currentIndex == 2,
            onTap: () => setState(() => currentIndex = 2),
          ),
        ],
      ),
    ),
  ),
)
```

---

## Content Components

### List Row

**iOS 26**: Row component with leading, content, and trailing areas.
**Flutter**: Custom `ListTile` with iOS 26 styling or `CupertinoListTile`.

#### Basic Row

```dart
CupertinoListTile(
  title: Text('Wi-Fi', style: IOS26Typography.body),
  trailing: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'Home Network',
        style: IOS26Typography.body.copyWith(
          color: IOS26Colors.labelSecondary,
        ),
      ),
      const SizedBox(width: 4),
      Icon(
        CupertinoIcons.chevron_right,
        size: 14,
        color: IOS26Colors.gray3,
      ),
    ],
  ),
)
```

#### Row with Switch

```dart
CupertinoListTile(
  title: Text('Airplane Mode', style: IOS26Typography.body),
  leading: Container(
    width: 30,
    height: 30,
    decoration: BoxDecoration(
      color: IOS26Colors.orange,
      borderRadius: BorderRadius.circular(7),
    ),
    child: const Icon(
      CupertinoIcons.airplane,
      color: Colors.white,
      size: 18,
    ),
  ),
  trailing: CupertinoSwitch(
    value: isAirplaneMode,
    activeTrackColor: IOS26Colors.green,
    onChanged: (value) => setState(() => isAirplaneMode = value),
  ),
)
```

#### Grouped List Section

```dart
CupertinoListSection.insetGrouped(
  header: Text(
    'GENERAL',
    style: IOS26Typography.footnote.copyWith(
      color: IOS26Colors.labelSecondary,
    ),
  ),
  backgroundColor: IOS26Colors.backgroundGroupedPrimary,
  children: [
    CupertinoListTile(
      title: Text('About', style: IOS26Typography.body),
      trailing: const CupertinoListTileChevron(),
    ),
    CupertinoListTile(
      title: Text('Software Update', style: IOS26Typography.body),
      trailing: const CupertinoListTileChevron(),
    ),
  ],
)
```

---

## Feedback Components

### Alert

**iOS 26**: Standard alert dialog with title, description, and action buttons.
**Flutter**: `CupertinoAlertDialog`.

```dart
showCupertinoDialog(
  context: context,
  builder: (context) => CupertinoAlertDialog(
    title: Text(
      'Delete Message',
      style: IOS26Typography.headline,
    ),
    content: Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        'This action cannot be undone. Are you sure?',
        style: IOS26Typography.subheadline.copyWith(
          color: IOS26Colors.labelSecondary,
        ),
      ),
    ),
    actions: [
      CupertinoDialogAction(
        isDefaultAction: true,
        child: const Text('Cancel'),
        onPressed: () => Navigator.pop(context),
      ),
      CupertinoDialogAction(
        isDestructiveAction: true,
        child: const Text('Delete'),
        onPressed: () {
          // Handle delete
          Navigator.pop(context);
        },
      ),
    ],
  ),
)
```

---

### Sheet

**iOS 26**: Bottom sheet with grabber, top toolbar, and scrollable content.
**Flutter**: `showCupertinoModalPopup` or `DraggableScrollableSheet`.

#### Simple Action Sheet

```dart
showCupertinoModalPopup(
  context: context,
  builder: (context) => CupertinoActionSheet(
    title: Text(
      'Share Photo',
      style: IOS26Typography.footnote.copyWith(
        color: IOS26Colors.labelSecondary,
      ),
    ),
    actions: [
      CupertinoActionSheetAction(
        child: const Text('Save to Photos'),
        onPressed: () => Navigator.pop(context),
      ),
      CupertinoActionSheetAction(
        child: const Text('Copy Link'),
        onPressed: () => Navigator.pop(context),
      ),
    ],
    cancelButton: CupertinoActionSheetAction(
      isDefaultAction: true,
      child: const Text('Cancel'),
      onPressed: () => Navigator.pop(context),
    ),
  ),
)
```

#### Draggable Sheet with Grabber

```dart
showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  backgroundColor: IOS26Colors.backgroundPrimary,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
  ),
  builder: (context) => DraggableScrollableSheet(
    initialChildSize: 0.5,
    minChildSize: 0.25,
    maxChildSize: 0.9,
    expand: false,
    builder: (context, scrollController) => Column(
      children: [
        // Grabber
        Container(
          margin: const EdgeInsets.only(top: 8, bottom: 4),
          width: 36,
          height: 5,
          decoration: BoxDecoration(
            color: IOS26Colors.gray3,
            borderRadius: BorderRadius.circular(2.5),
          ),
        ),
        // Toolbar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: Text(
                  'Cancel',
                  style: IOS26Typography.body.copyWith(
                    color: IOS26Colors.blue,
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              Text('Select Option', style: IOS26Typography.headline),
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: Text(
                  'Done',
                  style: IOS26Typography.bodyEmphasized.copyWith(
                    color: IOS26Colors.blue,
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
        const Divider(height: 0.5, color: IOS26Colors.separatorOpaque),
        // Content
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            itemCount: 20,
            itemBuilder: (context, index) => CupertinoListTile(
              title: Text('Item $index', style: IOS26Typography.body),
            ),
          ),
        ),
      ],
    ),
  ),
)
```

---

## Action Components

### Button

**iOS 26**: Filled, tinted, gray, plain, and Liquid Glass button styles.
**Flutter**: `CupertinoButton` with custom decoration or `ElevatedButton` with theme.

#### Filled Button (Primary)

```dart
CupertinoButton.filled(
  child: const Text('Continue'),
  onPressed: () {},
)
```

#### Tinted Button

```dart
CupertinoButton(
  color: IOS26Colors.blue.withValues(alpha: 0.15),
  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  borderRadius: BorderRadius.circular(14),
  child: Text(
    'Add to Cart',
    style: IOS26Typography.body.copyWith(color: IOS26Colors.blue),
  ),
  onPressed: () {},
)
```

#### Gray Button

```dart
CupertinoButton(
  color: IOS26Colors.fillTertiary,
  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  borderRadius: BorderRadius.circular(14),
  child: Text(
    'Cancel',
    style: IOS26Typography.body.copyWith(color: IOS26Colors.labelPrimary),
  ),
  onPressed: () {},
)
```

#### Liquid Glass Button (iOS 26 new)

```dart
GestureDetector(
  onTap: () {},
  child: LiquidGlass(
    size: LiquidGlassSize.small,
    mode: LiquidGlassMode.regular,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(CupertinoIcons.share, size: 18, color: IOS26Colors.blue),
        const SizedBox(width: 6),
        Text(
          'Share',
          style: IOS26Typography.body.copyWith(color: IOS26Colors.blue),
        ),
      ],
    ),
  ),
)
```

#### Destructive Button

```dart
CupertinoButton(
  child: Text(
    'Delete Account',
    style: IOS26Typography.body.copyWith(color: IOS26Colors.red),
  ),
  onPressed: () {},
)
```

---

## Input Components

### Search Bar

**iOS 26**: Rounded search field with search icon and cancel button.
**Flutter**: `CupertinoSearchTextField`.

```dart
CupertinoSearchTextField(
  placeholder: 'Search',
  style: IOS26Typography.body,
  placeholderStyle: IOS26Typography.body.copyWith(
    color: IOS26Colors.labelTertiary,
  ),
  backgroundColor: IOS26Colors.fillTertiary,
  borderRadius: BorderRadius.circular(10),
  onChanged: (value) {
    // Handle search
  },
)
```

---

### Segmented Control

**iOS 26**: Pill-shaped segmented control with sliding selection.
**Flutter**: `CupertinoSlidingSegmentedControl`.

```dart
CupertinoSlidingSegmentedControl<int>(
  groupValue: selectedSegment,
  thumbColor: IOS26Colors.backgroundPrimary,
  backgroundColor: IOS26Colors.fillTertiary,
  children: const {
    0: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Text('All'),
    ),
    1: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Text('Unread'),
    ),
    2: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Text('Flagged'),
    ),
  },
  onValueChanged: (value) {
    setState(() => selectedSegment = value!);
  },
)
```

---

## Material Components

### Background Material (Blur)

**iOS 26**: System blur materials behind navigation and overlay surfaces.
**Flutter**: `BackgroundMaterial` widget.

```dart
Stack(
  children: [
    // Scrollable content behind the blur
    ListView.builder(
      itemCount: 50,
      itemBuilder: (context, index) => ListTile(
        title: Text('Item $index'),
      ),
    ),

    // Blurred navigation bar overlay
    Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: BackgroundMaterial(
        variant: BackgroundMaterialVariant.regular,
        child: SafeArea(
          bottom: false,
          child: Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            child: Text('Title', style: IOS26Typography.headline),
          ),
        ),
      ),
    ),
  ],
)
```

---

### Scroll Edge Effect

**iOS 26**: Gradient fade at scroll boundaries.
**Flutter**: `ScrollEdgeEffect` widget.

```dart
ScrollEdgeEffect(
  edges: {ScrollEdge.top, ScrollEdge.bottom},
  mode: ScrollEdgeMode.soft,
  extent: 40,
  child: ListView.builder(
    itemCount: 100,
    itemBuilder: (context, index) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text('Row $index', style: IOS26Typography.body),
    ),
  ),
)
```

---

## Layout Patterns

### Grouped Settings Page

Complete example of an iOS 26 settings page layout:

```dart
CupertinoPageScaffold(
  backgroundColor: IOS26Colors.backgroundGroupedPrimary,
  navigationBar: CupertinoNavigationBar(
    middle: Text('Settings'),
    backgroundColor: IOS26Colors.backgroundGroupedPrimary,
    border: null,
  ),
  child: SafeArea(
    child: ListView(
      children: [
        const SizedBox(height: 16),

        // User profile section
        CupertinoListSection.insetGrouped(
          backgroundColor: IOS26Colors.backgroundGroupedPrimary,
          children: [
            CupertinoListTile(
              leading: CircleAvatar(
                radius: 28,
                backgroundColor: IOS26Colors.gray5,
                child: Text('SH', style: IOS26Typography.title2),
              ),
              title: Text('Seunghan', style: IOS26Typography.body),
              subtitle: Text(
                'Apple Account, iCloud & more',
                style: IOS26Typography.caption1.copyWith(
                  color: IOS26Colors.labelSecondary,
                ),
              ),
              trailing: const CupertinoListTileChevron(),
            ),
          ],
        ),

        // Connectivity section
        CupertinoListSection.insetGrouped(
          backgroundColor: IOS26Colors.backgroundGroupedPrimary,
          children: [
            CupertinoListTile(
              leading: _settingsIcon(CupertinoIcons.airplane, IOS26Colors.orange),
              title: Text('Airplane Mode', style: IOS26Typography.body),
              trailing: CupertinoSwitch(
                value: false,
                activeTrackColor: IOS26Colors.green,
                onChanged: (_) {},
              ),
            ),
            CupertinoListTile(
              leading: _settingsIcon(CupertinoIcons.wifi, IOS26Colors.blue),
              title: Text('Wi-Fi', style: IOS26Typography.body),
              additionalInfo: Text(
                'Home',
                style: IOS26Typography.body.copyWith(
                  color: IOS26Colors.labelSecondary,
                ),
              ),
              trailing: const CupertinoListTileChevron(),
            ),
          ],
        ),
      ],
    ),
  ),
)

Widget _settingsIcon(IconData icon, Color color) {
  return Container(
    width: 30,
    height: 30,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(7),
    ),
    child: Icon(icon, color: Colors.white, size: 18),
  );
}
```
