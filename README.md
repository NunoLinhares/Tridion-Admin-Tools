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
```
==========================================================
File:  C:\Program Files (x86)\SDL Web\bin\Tridion.Web.UI.CME.TcmExtensions.dll
==========================================================
 Method WebSiteSettingsSaveEventHandler extends object Type Publication with SaveApplicationDataEventArgs
 Method WebSiteSettingsDeleteEventHandler extends object Type Publication with DeleteApplicationDataEventArgs
 Method ClearWebSiteSettings extends object Type Publication with TcmEventArgs
 Method IdentifiableObjectEventHandler extends object Type IdentifiableObject with TcmEventArgs
==========================================================
File:  C:\Program Files (x86)\SDL Web\bin\Tridion.SiteEdit.TcmExtensions.dll
==========================================================
 Method PublicationCreatedEventHandler extends object Type Publication with SaveEventArgs
 Method PageDemoteEventHandler extends object Type Page with DemoteEventArgs
 Method ContentTypeItemDemoteEventHandler extends object Type RepositoryLocalObject with DemoteEventArgs
 Method HandleTcmRepositoryItemRemoved extends object Type IdentifiableObject with DeleteEventArgs
 Method HandleTcmRepositoryRemoveInitiated extends object Type Publication with DeleteEventArgs
 Method HandleTcmRepositoryRemoved extends object Type Publication with DeleteEventArgs
 Method ComponentCopyInitiatedEventHandler extends object Type Component with CopyEventArgs
 Method ComponentCopyProcessedEventHandler extends object Type Component with CopyEventArgs
 Method PageCopyInitiatedEventHandler extends object Type Page with CopyEventArgs
 Method PageCopyProcessedEventHandler extends object Type Page with CopyEventArgs
```
