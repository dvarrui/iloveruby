require 'fox16'
include Fox
require_relative "tree"

class AskerWindow < FXMainWindow
  def initialize(app)
    super(app, "Asker", nil, nil, DECOR_ALL, 0, 0, 600, 400)
    create_menu_bar
    create_body
  end

  def create
    super
    @concept_list.parent.parent.setWidth(@concept_list.font.getTextWidth('MMMMMMMMMMMMMMMM'))
    show(PLACEMENT_SCREEN)
  end

  private

  def create_menu_bar
    menubar = FXMenuBar.new(self, LAYOUT_FILL_X)
    filemenu = FXMenuPane.new(self)
    FXMenuCommand.new(filemenu, "&Quit\tCtl-Q", nil, getApp(), FXApp::ID_QUIT)
    FXMenuTitle.new(menubar, "&File", nil, filemenu)
    helpmenu = FXMenuPane.new(self)
    FXMenuCommand.new(helpmenu, "&About ASKER...").connect(SEL_COMMAND) {
      FXMessageBox.information(self, MBOX_OK, "About ASKER",
        "ASKER generates tons of questions\n" +
        "from a definitions input file.")
    }
    FXMenuTitle.new(menubar, "&Help", nil, helpmenu, LAYOUT_RIGHT)
  end

  def create_body
    contents = FXHorizontalFrame.new(self, LAYOUT_FILL_X|LAYOUT_FILL_Y)
    splitter = FXSplitter.new(contents, (LAYOUT_SIDE_TOP|LAYOUT_FILL_X|
      LAYOUT_FILL_Y|SPLITTER_TRACKING|SPLITTER_HORIZONTAL))
    create_concept_list(splitter)
    create_tabs(splitter)
  end

  def create_concept_list(splitter)
    groupbox = FXGroupBox.new(splitter, "Conceptos",
      LAYOUT_FILL_X|LAYOUT_FILL_Y|FRAME_GROOVE)
    frame = FXHorizontalFrame.new(groupbox,
      LAYOUT_FILL_X|LAYOUT_FILL_Y|FRAME_SUNKEN|FRAME_THICK)

    # Create the empty tree list
    @concept_list = FXTreeList.new(frame, nil, 0,
      (TREELIST_BROWSESELECT|TREELIST_SHOWS_LINES|TREELIST_SHOWS_BOXES|
       TREELIST_ROOT_BOXES|LAYOUT_FILL_X|LAYOUT_FILL_Y))
    @concept_list.connect(SEL_COMMAND) do |sender, sel, item|
      getApp().beginWaitCursor do
        @methods_text.text = Data.get_methods(item.to_s).join("\n")
        @constants_text.text = Data.get_constants(item.to_s).join("\n")
      end
    end

    populate_tree(@concept_list, nil, Tree.new.root)
  end

  def create_tabs(splitter)
    tabBook = FXTabBook.new(splitter, nil, 0, LAYOUT_FILL_X|LAYOUT_FILL_Y|LAYOUT_RIGHT)

    tab1 = FXTabItem.new(tabBook, "Methods")
    page1 = FXHorizontalFrame.new(tabBook, FRAME_THICK|FRAME_RAISED)
    frame1 = FXHorizontalFrame.new(page1,
      FRAME_THICK|FRAME_SUNKEN|LAYOUT_FILL_X|LAYOUT_FILL_Y)
    @methods_text = FXText.new(frame1, nil, 0, LAYOUT_FILL_X|LAYOUT_FILL_Y)
    @methods_text.text = "List of methods goes here"
    @methods_text.editable = false

    tab2 = FXTabItem.new(tabBook, "Constants")
    page2 = FXHorizontalFrame.new(tabBook, FRAME_THICK|FRAME_RAISED)
    frame2 = FXHorizontalFrame.new(page2,
      FRAME_THICK|FRAME_SUNKEN|LAYOUT_FILL_X|LAYOUT_FILL_Y)
    @constants_text = FXText.new(frame2, nil, 0, LAYOUT_FILL_X|LAYOUT_FILL_Y)
    @constants_text.text = "List of constants goes here"
    @constants_text.editable = false
  end

  def populate_tree(tree_list, root_item, root_node)
    root_node.children.each do |child_node|
      child_item = tree_list.appendItem(root_item, child_node.name)
      populate_tree(tree_list, child_item, child_node)
    end
  end
end
