{*?template charset=latin1?*}
{let has_warnings=false()}

  <form method="post" action="{$script}">

{section loop=$test.results}
{section-exclude match=true()}
{section-include match=is_set($:item.2.warnings)}
 {set has_warnings=true()}
{/section}

{section show=$has_warnings}
<div class="warning">
{section name=Result loop=$test.results}
{section-exclude match=true()}
{section-include match=is_set($Result:item.2.warnings)}
<h2>Warning</h2>
<ul>
 {section name=Warning loop=$Result:item.2.warnings}
  {section show=is_array($:item.text)}
 <li>{$:item.name}
 <ul>
  {section name=Text loop=$:item.text}
  <li>{$:item}</li>
  {/section}
 </ul>
  {section-else}
 <li>{$:item.text}</li>
  {/section}
 {/section}
</ul></li>
{/section}
</div>
{/section}

{section show=$test.result|eq(1)}
  <p>{"No problems was found with your system, you can continue by clicking the"|i18n("design/standard/setup/init")} <i>{"Next &gt;"|i18n("design/standard/setup/init")}</i> {"button."|i18n("design/standard/setup/init")}</p>

    <div class="buttonblock">
      <input type="hidden" name="ChangeStepAction" value="" />
      <input class="defaultbutton" type="submit" name="StepButton_4" value="{'Next'|i18n('design/standard/setup/init')} >>" />
      <input class="button" type="submit" name="StepButton_3" value="{'Finetune System'|i18n('design/standard/setup/init')} >" />
    </div>
    {include uri='design:setup/persistence.tpl'}

{section-else}

  <h1>{"System check"|i18n("design/standard/setup/init")}</h1>
  <p>
{"There are some important issues that have to be resolved. A list of issues / problems is presented below. Each section contains a description and a suggested / recommended solution."|i18n("design/standard/setup/init")}
</p><p>
{"Once the problems / issues are fixed, you may click the <i>Next</i> button to continue. The system check will be run again. If everything is okay, the setup will go to the next stage. If there are problems, the system check page will reappear."|i18n("design/standard/setup/init")}
</p><p>
{"Some issues may be ignored by checking the <i>Ignore this test</i> checkbox(es); however, this is not recommended."|i18n("design/standard/setup/init")}
</p>
{section show=eq( $optional_test.result, 2 )}
<p>
{"It is also possible to do some finetuning of your system, click <i>Finetune</i> instead <i>Next</i> if you want to see the finetuning hints."|i18n("design/standard/setup/init")}
</p>
{/section}

{*  {"The system check found some issues that need to be resolved before the setup can continue."|i18n("design/standard/setup/init")}
  {"Please have a look through the results below for more information on what the problems are."|i18n("design/standard/setup/init")}
  {"Each problem will give you instructions on how to fix the problem."|i18n("design/standard/setup/init")}
  </p>
  <p>{"After you have fixed the problems click the %1 button to re-run the system checking. You may also ignore specific tests by clicking the check boxes."|i18n("design/standard/setup/init",,array(concat("<i>","Next"|i18n("design/standard/setup/init"),"</i>")))}</p> *}

  <h1>{"Issues"|i18n("design/standard/setup/init")}</h1>
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
  {section name=Result loop=$test.results}
  {section-exclude match=$:item[0]|ne(2)}
  <tr>
    <td>{include uri=concat('design:setup/tests/',$:item[1],'_error.tpl') test_result=$:item result_number=$:number}</td>
  </tr>
  <tr>
    <td><input type="checkbox" name="{$:item[1]}_Ignore" value="1">{"Ignore this test"|i18n("design/standard/setup/init")}</input>
    </td>
  </tr>

  {delimiter}
  <tr><td>&nbsp;</td></tr>
  {/delimiter}

  {/section}
  </table>
    {include uri='design:setup/init/navigation.tpl' finetune=eq( $optional_test.result, 2 )}
    {include uri='design:setup/persistence.tpl'}
  </form>

{/section}
{/let}
