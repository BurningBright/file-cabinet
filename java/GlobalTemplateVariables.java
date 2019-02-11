package org.eclipse.jface.text.templates;

import com.ibm.icu.text.DateFormat;
import com.ibm.icu.text.SimpleDateFormat;
import com.ibm.icu.util.Calendar;
import java.util.Date;

public class GlobalTemplateVariables
{
  public static final String SELECTION = "selection";

  public static class Cursor extends SimpleTemplateVariableResolver
  {
    public static final String NAME = "cursor";

    public Cursor()
    {
      super(NAME, TextTemplateMessages.getString("GlobalVariables.variable.description.cursor"));
      setEvaluationString("");
    }
  }

  public static class Date extends SimpleTemplateVariableResolver
  {
    public Date()
    {
      super("date", TextTemplateMessages.getString("GlobalVariables.variable.description.date"));
    }
    protected String resolve(TemplateContext context) {
      //return DateFormat.getDateInstance().format(new Date());
	  final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      return sdf.format(new java.util.Date());
    }
  }

  public static class Dollar extends SimpleTemplateVariableResolver
  {
    public Dollar()
    {
      super("dollar", TextTemplateMessages.getString("GlobalVariables.variable.description.dollar"));
      setEvaluationString("$");
    }
  }

  public static class LineSelection extends SimpleTemplateVariableResolver
  {
    public static final String NAME = "line_selection";

    public LineSelection()
    {
      super(NAME, TextTemplateMessages.getString("GlobalVariables.variable.description.selectedLines"));
    }
    protected String resolve(TemplateContext context) {
      String selection = context.getVariable("selection");
      if (selection == null)
        return "";
      return selection;
    }
  }

  public static class Time extends SimpleTemplateVariableResolver
  {
    public Time()
    {
      super("time", TextTemplateMessages.getString("GlobalVariables.variable.description.time"));
    }

    protected String resolve(TemplateContext context)
    {
      //return DateFormat.getTimeInstance().format(new Date());
	  final SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
      return sdf.format(new java.util.Date());
    }
  }

  public static class User extends SimpleTemplateVariableResolver
  {
    public User()
    {
      super("user", TextTemplateMessages.getString("GlobalVariables.variable.description.user"));
    }

    protected String resolve(TemplateContext context)
    {
      return System.getProperty("user.name");
    }
  }

  public static class WordSelection extends SimpleTemplateVariableResolver
  {
    public static final String NAME = "word_selection";

    public WordSelection()
    {
      super(NAME, TextTemplateMessages.getString("GlobalVariables.variable.description.selectedWord"));
    }
    protected String resolve(TemplateContext context) {
      String selection = context.getVariable("selection");
      if (selection == null)
        return "";
      return selection;
    }
  }

  public static class Year extends SimpleTemplateVariableResolver
  {
    public Year()
    {
      super("year", TextTemplateMessages.getString("GlobalVariables.variable.description.year"));
    }
    protected String resolve(TemplateContext context) {
      return Integer.toString(Calendar.getInstance().get(1));
    }
  }
}