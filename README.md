# Tridion-Admin-Tools
Tools used to manage Tridion environments

This will hold the various scripts I end up writing used to manage Tridion machines

# GetTridionEventSystemExtensions

This script parses Tridion.ContentManager.Config and looks for assemblies registered as extensions
Then, per assembly, it will inspect the methods and find which objects are extended

## Usage

On a Tridion machine, browse to the folder where this file is and run
PS> .\GetTridionEventSystemExtensions.ps1

Output looks like this:

==========================================================
File:  C:\Program Files (x86)\SDL Web\bin\Tridion.Web.UI.CME.TcmExtensions.dll
==========================================================
 Method WebSiteSettingsSaveEventHandler extends object Publication on SaveApplicationData
 Method WebSiteSettingsDeleteEventHandler extends object Publication on DeleteApplicationData
 Method ClearWebSiteSettings extends object Publication on Tcm
 Method IdentifiableObjectEventHandler extends object IdentifiableObject on Tcm
==========================================================
File:  C:\Program Files (x86)\SDL Web\bin\Tridion.SiteEdit.TcmExtensions.dll
==========================================================
 Method PublicationCreatedEventHandler extends object Publication on Save
 Method PageDemoteEventHandler extends object Page on Demote
 Method ContentTypeItemDemoteEventHandler extends object RepositoryLocalObject on Demote
 Method HandleTcmRepositoryItemRemoved extends object IdentifiableObject on Delete
 Method HandleTcmRepositoryRemoveInitiated extends object Publication on Delete
 Method HandleTcmRepositoryRemoved extends object Publication on Delete
 Method ComponentCopyInitiatedEventHandler extends object Component on Copy
 Method ComponentCopyProcessedEventHandler extends object Component on Copy
 Method PageCopyInitiatedEventHandler extends object Page on Copy
 Method PageCopyProcessedEventHandler extends object Page on Copy

