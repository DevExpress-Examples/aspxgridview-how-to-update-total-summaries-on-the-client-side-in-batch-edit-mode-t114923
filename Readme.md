<!-- default file list -->
*Files to look at*:

* [Default.aspx](./CS/Default.aspx) (VB: [Default.aspx](./VB/Default.aspx))
* [Default.aspx.cs](./CS/Default.aspx.cs) (VB: [Default.aspx.vb](./VB/Default.aspx.vb))
<!-- default file list end -->
# ASPxGridView - How to update total summaries on the client side in Batch Edit mode


<p>This example demonstrates how to update total summaries on the client side when ASPxGridView is in Batch Edit mode. </p>
<p>You can find detailed steps by clicking below the "Show Implementation Details" link .<br><br><strong>See Also:<br><a href="https://www.devexpress.com/Support/Center/p/T517531">ASPxGridView - Batch Editing - How to update total summaries on the client side when BatchEditSettings.HighlightDeletedRows = true</a></strong></p>
<p><a href="https://www.devexpress.com/Support/Center/p/T114539">ASPxGridView - Batch Edit - How to calculate values on the fly</a> <br><a href="https://www.devexpress.com/Support/Center/p/T116925">ASPxGridView - Batch Edit - How to calculate unbound column and total summary values on the fly</a> <br><br><strong>ASP.NET MVC Example:</strong><br><a href="https://www.devexpress.com/Support/Center/p/T137186">GridView - How to update total summaries on the client side in Batch Edit mode</a></p>


<h3>Description</h3>

<p>To implement the required task, perform the following steps:</p>
<p><br>1. Add a total summary item for a required column. The&nbsp;<a href="https://documentation.devexpress.com/#AspNet/DevExpressWebASPxGridViewASPxSummaryItem_Tagtopic">ASPxSummaryItem.Tag</a>&nbsp;property is used to find this summary item on the server side:&nbsp;</p>
<code lang="aspx">&lt;Settings ShowFooter="true" /&gt;
&lt;TotalSummary&gt;
	&lt;dx:ASPxSummaryItem SummaryType="Sum" FieldName="C2" Tag="C2_Sum" /&gt;
&lt;/TotalSummary&gt;
</code>
<p>&nbsp;2. Replace&nbsp;the summary item with a custom Footer template:</p>
<code lang="aspx">&lt;dx:GridViewDataSpinEditColumn FieldName="C2"&gt;
	&lt;FooterTemplate&gt;
		Sum =
		&lt;dx:ASPxLabel ID="ASPxLabel1" runat="server" ClientInstanceName="labelSum" Text='&lt;%# GetTotalSummaryValue() %&gt;'&gt;
		&lt;/dx:ASPxLabel&gt;
	&lt;/FooterTemplate&gt;
&lt;/dx:GridViewDataSpinEditColumn&gt;</code>
<p>&nbsp;The&nbsp;<strong><em>GetTotalSummaryValue</em></strong><em>&nbsp;</em>method is used to get the actual summary value when the grid is initialized:</p>
<code lang="cs">    protected object GetTotalSummaryValue() {
        ASPxSummaryItem summaryItem = Grid.TotalSummary.First(i =&gt; i.Tag == "C2_Sum");
        return Grid.GetTotalSummaryValue(summaryItem);
    }
</code>
<p>&nbsp;3. &nbsp;&nbsp;Handle the grid's client-side&nbsp;<a href="https://documentation.devexpress.com/#AspNet/DevExpressWebASPxGridViewScriptsASPxClientGridView_BatchEditEndEditingtopic">BatchEditEndEditing</a>&nbsp;event to calculate a new summary value and set it when any cell value has been changed:</p>
<code lang="js">function OnBatchEditEndEditing(s, e) {
	var originalValue = s.batchEditApi.GetCellValue(e.visibleIndex, "C2");
	var newValue = e.rowValues[(s.GetColumnByField("C2").index)].value;
&nbsp;	var dif = newValue - originalValue;
	labelSum.SetValue((parseFloat(labelSum.GetValue()) + dif).toFixed(1));
}
</code>
<p>4. Finally, replace standard <em><strong>Save changes</strong></em> and <em><strong>Cancel changes</strong></em> buttons with custom buttons to refresh a summary value when all modifications have been canceled:</p>
<code lang="aspx">&lt;Templates&gt;
	&lt;StatusBar&gt;
		&lt;div style="text-align: right"&gt;
			&lt;dx:ASPxHyperLink ID="hlSave" runat="server" Text="Save changes"&gt;
				&lt;ClientSideEvents Click="function(s, e){ gridView.UpdateEdit(); }" /&gt;
			&lt;/dx:ASPxHyperLink&gt;
			 
			&lt;dx:ASPxHyperLink ID="hlCancel" runat="server" Text="Cancel changes"&gt;
				&lt;ClientSideEvents Click="function(s, e){ gridView.CancelEdit(); gridView.Refresh(); }" /&gt;
			&lt;/dx:ASPxHyperLink&gt;
		&lt;/div&gt;
	&lt;/StatusBar&gt;
&lt;/Templates&gt;</code>

<br/>


