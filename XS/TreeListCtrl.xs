#################################################################################
# Name:        XS/TreeListCtrl.xs
# Purpose:     XS for Wx::TreeListCtrl
# Author:      Mark Wardell
# Modified by:
# Created:     08/08/2006
# RCS-ID:      $Id: TreeListCtrl.xs 22 2010-02-10 05:09:05Z  $
# Copyright:   (c) 2006 - 2010 Mark Wardell
# Licence:     This program is free software; you can redistribute it and/or
#              modify it under the same terms as Perl itself
##################################################################################

#include <cpp/helpers.h>   // again - for wxPliTreeItemData

MODULE = Wx__TreeListCtrl   PACKAGE = Wx::TreeListCtrl

void
new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( newDefault )
        MATCH_ANY_REDISP( newFull )
    END_OVERLOAD( "Wx::TreeListCtrl::new" )


wxTreeListCtrl*
newDefault( CLASS )
    PlClassName CLASS
  CODE:
    RETVAL = new wxPliTreeListCtrl( CLASS );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT: RETVAL


wxTreeListCtrl*
newFull( CLASS, parent, id, pos = wxDefaultPosition, size = wxDefaultSize, style = wxTR_HAS_BUTTONS, validator = (wxValidator*)&wxDefaultValidator, name = wxT("TreeListCtrl") )
    PlClassName CLASS
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
    wxValidator* validator
    wxString name
  CODE:
    RETVAL = new wxPliTreeListCtrl( CLASS, parent, id, pos, size, style, *validator, name );
  OUTPUT:
    RETVAL

bool
wxTreeListCtrl::Create( parent, id, pos = wxDefaultPosition, size = wxDefaultSize, style = wxTR_HAS_BUTTONS, validator = (wxValidator*)&wxDefaultValidator, name = wxT("TreeListCtrl") )
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
    wxValidator* validator
    wxString name
  C_ARGS: parent, id, pos, size, style, *validator, name

void
wxTreeListCtrl::Refresh( erase = true, rect = NULL )
	bool erase
	wxRect* rect

void
wxTreeListCtrl::SetFocus()

size_t
wxTreeListCtrl::GetCount()

unsigned int
wxTreeListCtrl::GetIndent()

void
wxTreeListCtrl::SetIndent( indent )
	unsigned int indent

unsigned int
wxTreeListCtrl::GetLineSpacing()

void
wxTreeListCtrl::SetLineSpacing( spacing )
	unsigned int spacing

wxImageList*
wxTreeListCtrl::GetImageList()
  CODE:
    RETVAL = (wxImageList*)THIS->GetImageList();
  OUTPUT:
    RETVAL
  CLEANUP:
    wxPli_object_set_deleteable( aTHX_ ST(0), false );


wxImageList*
wxTreeListCtrl::GetStateImageList()
  CODE:
    RETVAL = (wxImageList*)THIS->GetStateImageList();
  OUTPUT:
    RETVAL
  CLEANUP:
    wxPli_object_set_deleteable( aTHX_ ST(0), false );


wxImageList*
wxTreeListCtrl::GetButtonsImageList()
  CODE:
    RETVAL = (wxImageList*)THIS->GetButtonsImageList();
  OUTPUT:
    RETVAL
  CLEANUP:
    wxPli_object_set_deleteable( aTHX_ ST(0), false );

void
wxTreeListCtrl::SetImageList( imagelist )
    wxImageList* imagelist

void
wxTreeListCtrl::AssignImageList( imagelist )
    wxImageList* imagelist
  CODE:
    wxPli_object_set_deleteable( aTHX_ ST(1), false );
    THIS->AssignImageList( imagelist );
    
void
wxTreeListCtrl::SetStateImageList( imagelist )
    wxImageList* imagelist

void
wxTreeListCtrl::AssignStateImageList( imagelist )
    wxImageList* imagelist
  CODE:
    wxPli_object_set_deleteable( aTHX_ ST(1), false );
    THIS->AssignStateImageList( imagelist );

void
wxTreeListCtrl::SetButtonsImageList( imagelist )
    wxImageList* imagelist

void
wxTreeListCtrl::AssignButtonsImageList( imagelist )
    wxImageList* imagelist
  CODE:
    wxPli_object_set_deleteable( aTHX_ ST(1), false );
    THIS->AssignButtonsImageList( imagelist );    

##
## Functions to work with columns
##

## DECLARE_OVERLOAD( wtlc, Wx::TreeListColumnInfo )

void
wxTreeListCtrl::AddColumn( ... )
    PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP_COUNT( wxPliOvl_wtlc, AddColumnInfo, 1 )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_s_n_n_n_n_n, AddColumnFull, 1 )
    END_OVERLOAD( Wx::TreeListCtrl::AddColumn )

void
wxTreeListCtrl::AddColumnFull ( text, width = DEFAULT_COL_WIDTH, flag = wxALIGN_LEFT, image = -1, shown = true, edit = false )
	wxString text
	int width
	int flag
	int image
	bool shown
	bool edit
  CODE:
    THIS->AddColumn( text, width, flag, image, shown, edit );


void
wxTreeListCtrl::AddColumnInfo ( colInfo )
    wxTreeListColumnInfo* colInfo
  CODE:
    THIS->AddColumn( colInfo->GetInternalInfoObject() );

void
wxTreeListCtrl::InsertColumn( ... )
    PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP_COUNT( wxPliOvl_n_wtlc, InsertColumnInfo, 2 )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_n_s_n_n_n_n_n, InsertColumnFull, 2 )
    END_OVERLOAD( Wx::TreeListCtrl::InsertColumn )

void
wxTreeListCtrl::InsertColumnFull ( before, text, width = DEFAULT_COL_WIDTH, flag = wxALIGN_LEFT, image = -1, shown = true, edit = false )
	int before
	wxString text
	int width
	int flag
	int image
	bool shown
	bool edit
  CODE:
    THIS->InsertColumn( before, text, width, flag, image, shown, edit );

void
wxTreeListCtrl::InsertColumnInfo ( before, colInfo )
    int before
    wxTreeListColumnInfo* colInfo
  CODE:
    THIS->InsertColumn( before, colInfo->GetInternalInfoObject() );

void
wxTreeListCtrl::RemoveColumn ( column )
    int column 

int
wxTreeListCtrl::GetColumnCount()

void
wxTreeListCtrl::SetMainColumn( column )
	int column

int
wxTreeListCtrl::GetMainColumn()


void
wxTreeListCtrl::SetColumn( column, colInfo )
    int column
    wxTreeListColumnInfo* colInfo
  CODE:
    THIS->SetColumn( column, colInfo->GetInternalInfoObject() );
    
wxTreeListColumnInfo*
wxTreeListCtrl::GetColumn( column )
    int column
  CODE:
    RETVAL = new wxTreeListColumnInfo( THIS->GetColumn( column ) );
  OUTPUT:
    RETVAL
    
void
wxTreeListCtrl::SetColumnText( col, text )
	int col
	wxString text

wxString
wxTreeListCtrl::GetColumnText( col )
    int col

void
wxTreeListCtrl::SetColumnWidth( col, width )
    int col
    int width

int
wxTreeListCtrl::GetColumnWidth( col )
    int col
   
void
wxTreeListCtrl::SetColumnAlignment( col, flag )
    int col
    int flag

int
wxTreeListCtrl::GetColumnAlignment( col )
    int col

void
wxTreeListCtrl::SetColumnImage( col, image )
    int col
    int image

int
wxTreeListCtrl::GetColumnImage( col )
    int col

void
wxTreeListCtrl::SetColumnShown( col, shown = true )
    int col
    bool shown

bool
wxTreeListCtrl::IsColumnShown( col )
    int col

void
wxTreeListCtrl::SetColumnEditable( col, edit = true )
    int col
    bool edit 

bool
wxTreeListCtrl::IsColumnEditable( col )
    int col


## DECLARE_OVERLOAD( wtid, Wx::TreeItemId )

void
wxTreeListCtrl::GetItemText( ... )
    PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP_COUNT( wxPliOvl_wtid, GetItemTextMain, 1 )
        MATCH_REDISP_COUNT( wxPliOvl_wtid_n, GetItemColumnText, 2 )
    END_OVERLOAD( Wx::TreeListCtrl::GetItemText )
    
wxString
wxTreeListCtrl::GetItemTextMain( item )
    wxTreeItemId* item
  CODE:
    RETVAL =THIS->GetItemText( *item );
  OUTPUT:
    RETVAL
  
wxString
wxTreeListCtrl::GetItemColumnText( item, col )
    wxTreeItemId* item
    int col
  CODE:
    RETVAL =THIS->GetItemText( *item, col );
  OUTPUT:
    RETVAL

void
wxTreeListCtrl::GetItemImage( ... )
    PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_wtid_n, GetItemImageMain, 1 )
        MATCH_REDISP_COUNT( wxPliOvl_wtid_n_n, GetItemColumnImage, 3 )
    END_OVERLOAD( Wx::TreeListCtrl::GetItemImage )
    
int
wxTreeListCtrl::GetItemImageMain( item, which = wxTreeItemIcon_Normal )
    wxTreeItemId* item
    wxTreeItemIcon which
  CODE:
    RETVAL = THIS->GetItemImage( *item, which);
  OUTPUT:
    RETVAL

int
wxTreeListCtrl::GetItemColumnImage( item, col, which )
    wxTreeItemId* item
    int col
    wxTreeItemIcon which
  CODE:
    RETVAL = THIS->GetItemImage( *item, col, which);
  OUTPUT:
    RETVAL

wxTreeItemData*
wxTreeListCtrl::GetItemData( item )
    wxTreeItemId* item
  CODE:
    RETVAL = THIS->GetItemData( *item );
  OUTPUT:
    RETVAL

SV_null*
wxTreeListCtrl::GetPlData( item )
    wxTreeItemId* item
  CODE:
    wxPliTreeItemData* data = (wxPliTreeItemData*) THIS->GetItemData( *item );
    RETVAL = data ? data->m_data : 0;
  OUTPUT:
    RETVAL

bool
wxTreeListCtrl::GetItemBold ( item )
    wxTreeItemId* item
  C_ARGS: *item

wxColour*
wxTreeListCtrl::GetItemTextColour( item )
    wxTreeItemId* item
  CODE:
    RETVAL = new wxColour( THIS->GetItemTextColour( *item ) );
  OUTPUT:
    RETVAL

wxColour*
wxTreeListCtrl::GetItemBackgroundColour( item )
	wxTreeItemId* item
  CODE:
    RETVAL = new wxColour( THIS->GetItemBackgroundColour( *item ) );
  OUTPUT:
    RETVAL

wxFont*
wxTreeListCtrl::GetItemFont( item )
	wxTreeItemId* item
  CODE:
    RETVAL = new wxFont( THIS->GetItemFont( *item ) );
  OUTPUT:
    RETVAL

##
## Modifiers
##

void
wxTreeListCtrl::SetItemText( ... )
    PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP_COUNT( wxPliOvl_wtid_s, SetItemTextMain, 2 )
        MATCH_REDISP_COUNT( wxPliOvl_wtid_n_s, SetItemColumnText, 3 )
    END_OVERLOAD( Wx::TreeListCtrl::SetItemText )

void
wxTreeListCtrl::SetItemTextMain( item, text )
	wxTreeItemId* item
	wxString text
  CODE:
    THIS->SetItemText( *item, text );
    
void
wxTreeListCtrl::SetItemColumnText( item, col, text )
	wxTreeItemId* item
	int col
	wxString text
  CODE:
    THIS->SetItemText( *item, col, text );

void
wxTreeListCtrl::SetItemImage( ... )
    PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_wtid_n_n, SetItemImageMain, 2 )
        MATCH_REDISP_COUNT( wxPliOvl_wtid_n_n_n, SetItemColumnImage, 4 )
    END_OVERLOAD( Wx::TreeListCtrl::SetItemImage )
    
void
wxTreeListCtrl::SetItemImageMain( item, image, which = wxTreeItemIcon_Normal )
    wxTreeItemId* item
    int image
    wxTreeItemIcon which
  CODE:
    THIS->SetItemImage( *item, image, which );
  
void
wxTreeListCtrl::SetItemColumnImage( item, col, image, which )
    wxTreeItemId* item
    int col
    int image
    wxTreeItemIcon which
  CODE:
    THIS->SetItemImage( *item, col, image, which );


void
wxTreeListCtrl::SetItemData( item, data )
    wxTreeItemId* item
    wxTreeItemData* data
  CODE:
    wxTreeItemData* tid = THIS->GetItemData( *item );
    if( tid ) delete tid;
    THIS->SetItemData( *item, data );

void
wxTreeListCtrl::SetItemHasChildren( item, hasChildren = true )
    wxTreeItemId* item
    bool hasChildren
  C_ARGS: *item, hasChildren

void
wxTreeListCtrl::SetItemBold( item, bold = true )
    wxTreeItemId* item
    bool bold
  C_ARGS: *item, bold

void
wxTreeListCtrl::SetItemTextColour( item, col )
    wxTreeItemId* item
    wxColour col
  C_ARGS: *item, col

void
wxTreeListCtrl::SetItemBackgroundColour( item, col )
    wxTreeItemId* item
    wxColour col
  C_ARGS: *item, col

void
wxTreeListCtrl::SetItemFont( item, font )
    wxTreeItemId* item
    wxFont* font
  C_ARGS: *item, *font

void
wxTreeListCtrl::SetFont( font )
    wxFont* font
  C_ARGS: *font

void
wxTreeListCtrl::SetWindowStyle( style )
    long style

long
wxTreeListCtrl::GetWindowStyle()

long
wxTreeListCtrl::GetWindowStyleFlag()


##
## Status Enquiries
##

bool
wxTreeListCtrl::IsVisible (item, fullRow = false)
	wxTreeItemId* item
	bool fullRow
  C_ARGS: *item, fullRow

bool
wxTreeListCtrl::HasChildren ( item )
	wxTreeItemId* item
  C_ARGS: *item

bool
wxTreeListCtrl::IsExpanded ( item )
	wxTreeItemId* item
  C_ARGS: *item

bool
wxTreeListCtrl::IsSelected ( item )
	wxTreeItemId* item
  C_ARGS: *item

bool
wxTreeListCtrl::IsBold ( item )
	wxTreeItemId* item
  C_ARGS: *item

size_t
wxTreeListCtrl::GetChildrenCount ( item, recursively = true );
	wxTreeItemId* item
	bool recursively
  C_ARGS: *item, recursively


##
## Navigation
##

wxTreeItemId*
wxTreeListCtrl::GetRootItem()
  CODE:
    RETVAL = new wxTreeItemId( THIS->GetRootItem() );
  OUTPUT:
    RETVAL

wxTreeItemId*
wxTreeListCtrl::GetSelection()
  CODE:
    RETVAL = new wxTreeItemId( THIS->GetSelection() );
  OUTPUT:
    RETVAL

void
wxTreeListCtrl::GetSelections()
  PREINIT:
    wxArrayTreeItemIds selections;
  PPCODE:
    size_t num = THIS->GetSelections( selections );
    EXTEND( SP, (IV)num );
    for( size_t i = 0; i < num; ++i )
    {
        PUSHs( wxPli_non_object_2_sv( aTHX_ sv_newmortal(),
                                      new wxTreeItemId( selections[i] ),
                                      "Wx::TreeItemId" ) );
    }

wxTreeItemId*
wxTreeListCtrl::GetItemParent ( item )
	wxTreeItemId* item
  CODE:
    RETVAL = new wxTreeItemId( THIS->GetItemParent( *item ) );
  OUTPUT:
    RETVAL
    
wxTreeItemId*
wxTreeListCtrl::GetCurrentItem ()
  CODE:
    RETVAL = new wxTreeItemId( THIS->GetCurrentItem() );
  OUTPUT:
    RETVAL
    
void
wxTreeListCtrl::SetCurrentItem ( item )
    wxTreeItemId* item
  CODE:
    THIS->SetCurrentItem( *item );

void
wxTreeListCtrl::GetFirstChild( item )
    wxTreeItemId* item
  PREINIT:
    void* cookie;
  PPCODE:
    wxTreeItemId ret = THIS->GetFirstChild( *item, cookie );
    EXTEND( SP, 2 );
    PUSHs( wxPli_non_object_2_sv( aTHX_ sv_newmortal(),
                                  new wxTreeItemId( ret ),
                                  "Wx::TreeItemId" ) );
    PUSHs( sv_2mortal( newSViv( PTR2IV( cookie ) ) ) );
  
void
wxTreeListCtrl::GetNextChild( item, cookie )
    wxTreeItemId* item
    IV cookie
  PREINIT:
    void* realcookie = INT2PTR( void*, cookie );
  PPCODE:
    wxTreeItemId ret = THIS->GetNextChild( *item, realcookie );
    EXTEND( SP, 2 );
    PUSHs( wxPli_non_object_2_sv( aTHX_ sv_newmortal(),
                                  new wxTreeItemId( ret ),
                                  "Wx::TreeItemId" ) );
    PUSHs( sv_2mortal( newSViv( PTR2IV( realcookie ) ) ) );
    
void
wxTreeListCtrl::GetPrevChild( item, cookie )
    wxTreeItemId* item
    IV cookie
  PREINIT:
    void* realcookie = INT2PTR( void*, cookie );
  PPCODE:
    wxTreeItemId ret = THIS->GetPrevChild( *item, realcookie );
    EXTEND( SP, 2 );
    PUSHs( wxPli_non_object_2_sv( aTHX_ sv_newmortal(),
                                  new wxTreeItemId( ret ),
                                  "Wx::TreeItemId" ) );
    PUSHs( sv_2mortal( newSViv( PTR2IV( realcookie ) ) ) );    

void
wxTreeListCtrl::GetLastChild( item )
    wxTreeItemId* item
  PREINIT:
    void* cookie;
  PPCODE:
    wxTreeItemId ret = THIS->GetLastChild( *item, cookie );
    EXTEND( SP, 2 );
    PUSHs( wxPli_non_object_2_sv( aTHX_ sv_newmortal(),
                                  new wxTreeItemId( ret ),
                                  "Wx::TreeItemId" ) );
    PUSHs( sv_2mortal( newSViv( PTR2IV( cookie ) ) ) );

wxTreeItemId*
wxTreeListCtrl::GetNextSibling ( item )
	wxTreeItemId* item
  CODE:
    RETVAL = new wxTreeItemId( THIS->GetNextSibling( *item ) );
  OUTPUT:
    RETVAL

wxTreeItemId*
wxTreeListCtrl::GetPrevSibling ( item )
	wxTreeItemId* item
  CODE:
    RETVAL = new wxTreeItemId( THIS->GetPrevSibling( *item ) );
  OUTPUT:
    RETVAL

wxTreeItemId*
wxTreeListCtrl::GetNext ( item )
	wxTreeItemId* item
  CODE:
    RETVAL = new wxTreeItemId( THIS->GetNext( *item ) );
  OUTPUT:
    RETVAL

wxTreeItemId*
wxTreeListCtrl::GetPrev ( item )
	wxTreeItemId* item
  CODE:
    RETVAL = new wxTreeItemId( THIS->GetPrev( *item ) );
  OUTPUT:
    RETVAL

# get expanded items
wxTreeItemId*
wxTreeListCtrl::GetFirstExpandedItem()
  CODE:
    RETVAL = new wxTreeItemId( THIS->GetFirstExpandedItem() );
  OUTPUT:
    RETVAL

wxTreeItemId*
wxTreeListCtrl::GetNextExpanded ( item )
	wxTreeItemId* item
  CODE:
    RETVAL = new wxTreeItemId( THIS->GetNextExpanded( *item ) );
  OUTPUT:
    RETVAL

wxTreeItemId*
wxTreeListCtrl::GetPrevExpanded ( item )
	wxTreeItemId* item
  CODE:
    RETVAL = new wxTreeItemId( THIS->GetPrevExpanded( *item ) );
  OUTPUT:
    RETVAL

# get visible items
wxTreeItemId*
wxTreeListCtrl::GetFirstVisibleItem()
  CODE:
    RETVAL = new wxTreeItemId( THIS->GetFirstVisibleItem() );
  OUTPUT:
    RETVAL

wxTreeItemId*
wxTreeListCtrl::GetNextVisible ( item, fullrow = false )
	wxTreeItemId* item
	bool fullrow
  CODE:
    RETVAL = new wxTreeItemId( THIS->GetNextVisible( *item, fullrow ) );
  OUTPUT:
    RETVAL

wxTreeItemId*
wxTreeListCtrl::GetPrevVisible ( item, fullrow = false )
	wxTreeItemId* item
	bool fullrow
  CODE:
    RETVAL = new wxTreeItemId( THIS->GetPrevVisible( *item, fullrow ) );
  OUTPUT:
    RETVAL

##
## Operations
##
wxTreeItemId*
wxTreeListCtrl::AddRoot( text, image = -1, selImage = -1, data = 0 )
	wxString text
	int image
	int selImage
	wxTreeItemData* data
  CODE:
	RETVAL = new wxTreeItemId( THIS->AddRoot( text, image, selImage, data ) );
  OUTPUT:
	RETVAL

wxTreeItemId*
wxTreeListCtrl::PrependItem( parent, text, image = -1, selImage = -1, data = 0 )
	wxTreeItemId* parent
	wxString text
	int image
	int selImage
	wxTreeItemData* data
  CODE:
	RETVAL = new wxTreeItemId( THIS->PrependItem( *parent, text, image, selImage, data ) );
  OUTPUT:
	RETVAL

wxTreeItemId*
wxTreeListCtrl::AppendItem( parent, text, image = -1, selImage = -1, data = 0 )
	wxTreeItemId* parent
	wxString text
	int image
	int selImage
	wxTreeItemData* data
  CODE:
	RETVAL = new wxTreeItemId( THIS->AppendItem( *parent, text, image, selImage, data ) );
  OUTPUT:
	RETVAL
        
## DECLARE_OVERLOAD( wtda, Wx::TreeItemData )

void
wxTreeListCtrl::InsertItem( ... )
    PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_wtid_wtid_s_n_n_wtda, InsertItemAfter, 3 )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_wtid_n_s_n_n_wtda, InsertItemBefore, 3 )
    END_OVERLOAD( Wx::TreeListCtrl::InsertItem )        

wxTreeItemId*
wxTreeListCtrl::InsertItemAfter( parent, previous, text, image = -1, selImage = -1, data = (wxTreeItemData*)NULL )
	wxTreeItemId* parent
        wxTreeItemId* previous
	wxString text
	int image
	int selImage
	wxTreeItemData* data
  CODE:
	RETVAL = new wxTreeItemId( THIS->InsertItem( *parent, *previous, text, image, selImage, data ) );
  OUTPUT:
	RETVAL
        
wxTreeItemId*
wxTreeListCtrl::InsertItemBefore( parent, index, text, image = -1, selImage = -1, data = (wxTreeItemData*)NULL )
	wxTreeItemId* parent
        size_t index
	wxString text
	int image
	int selImage
	wxTreeItemData* data
  CODE:
	RETVAL = new wxTreeItemId( THIS->InsertItem( *parent, index, text, image, selImage, data ) );
  OUTPUT:
	RETVAL

void
wxTreeListCtrl::Delete ( item )
	wxTreeItemId* item
  C_ARGS: *item

void
wxTreeListCtrl::DeleteChildren ( item )
	wxTreeItemId* item
  C_ARGS: *item

void
wxTreeListCtrl::DeleteRoot ()

void
wxTreeListCtrl::Expand( item )
	wxTreeItemId* item
  C_ARGS: *item

void
wxTreeListCtrl::ExpandAll( item )
	wxTreeItemId* item
  C_ARGS: *item

void
wxTreeListCtrl::Collapse( item )
	wxTreeItemId* item
  C_ARGS: *item

void
wxTreeListCtrl::CollapseAndReset( item )
	wxTreeItemId* item
  C_ARGS: *item

void
wxTreeListCtrl::Toggle( item )
	wxTreeItemId* item
  C_ARGS: *item

void
wxTreeListCtrl::Unselect()

void
wxTreeListCtrl::UnselectAll()

void
wxTreeListCtrl::SelectAll()

void
wxTreeListCtrl::SelectItem( ... )
    PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_wtid_wtid_n, SelectItemRange, 2 )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_wtid_n, SelectItemSingle, 1 )
    END_OVERLOAD( Wx::TreeListCtrl::SelectItem )

void
wxTreeListCtrl::SelectItemSingle( item, unselect_others = 1 )
    wxTreeItemId* item
    bool unselect_others
  CODE:
    THIS->SelectItem( *item, NULL, unselect_others );
  
void
wxTreeListCtrl::SelectItemRange( first, last, unselect_others = 1 )
    wxTreeItemId* first
    wxTreeItemId* last
    bool unselect_others
  CODE:
    THIS->SelectItem( *first, *last, unselect_others );
    
void
wxTreeListCtrl::EnsureVisible( item )
    wxTreeItemId* item
  C_ARGS: *item
  
void
wxTreeListCtrl::ScrollTo( item )
    wxTreeItemId* item
  C_ARGS: *item
  
void
wxTreeListCtrl::HitTest( point )
    wxPoint point
  PREINIT:
    int flags;
  PPCODE:
    wxTreeItemId ret = THIS->HitTest( point, flags );
    EXTEND( SP, 2 );
    PUSHs( wxPli_non_object_2_sv( aTHX_ sv_newmortal(),
                                  new wxTreeItemId( ret ),
                                  "Wx::TreeItemId" ) );
    PUSHs( sv_2mortal( newSViv( flags ) ) );


void
wxTreeCtrl::GetBoundingRect( item, textOnly = false )
    wxTreeItemId* item
    bool textOnly
  PREINIT:
    wxRect rect;
  PPCODE:
    bool ret = THIS->GetBoundingRect( *item, rect, textOnly );
    if( ret )
    {
        SV* ret = sv_newmortal();
        wxPli_non_object_2_sv( aTHX_ ret, new wxRect( rect ), "Wx::Rect" );
        XPUSHs( ret );
    }
    else
    {
        XSRETURN_UNDEF;
    }


void
wxTreeListCtrl::EditLabel(item, column)
    wxTreeItemId* item
    int column
  C_ARGS: *item, column
  
  
void
wxTreeListCtrl::EditLabelMain(item)
    wxTreeItemId* item
  CODE:
    THIS->EditLabel( *item );
 
int
wxTreeListCtrl::OnCompareItems( item1, item2 )
    wxTreeItemId* item1
    wxTreeItemId* item2
  CODE:
    RETVAL = THIS->OnCompareItems( *item1, *item2 );
  OUTPUT:
    RETVAL
  
void
wxTreeListCtrl::SortChildren( item )
    wxTreeItemId* item
  C_ARGS: *item
  
wxTreeItemId*
wxTreeListCtrl::FindItem ( item, str, mode )
    wxTreeItemId* item
    wxString str
    int mode
  CODE:
    RETVAL = new wxTreeItemId( THIS->FindItem( *item, str, mode ) );
  OUTPUT:
    RETVAL
    
bool
wxTreeListCtrl::SetBackgroundColour( colour )
    wxColour* colour
  C_ARGS: *colour
  
bool
wxTreeListCtrl::SetForegroundColour( colour )
    wxColour* colour
  C_ARGS: *colour
  
void
wxTreeListCtrl::SetDragItem (item = (wxTreeItemId*)NULL)
    wxTreeItemId* item
  C_ARGS: *item

wxTreeListHeaderWindow*
wxTreeListCtrl::GetHeaderWindow()

wxTreeListMainWindow*
wxTreeListCtrl::GetMainWindow()
    
wxSize*
wxTreeListCtrl::DoGetBestSize()  
  CODE:
    RETVAL = new wxSize( THIS->DoGetBestSize() );
  OUTPUT:
    RETVAL


MODULE=Wx__TreeListCtrl
