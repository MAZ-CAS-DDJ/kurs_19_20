# PLOTTING CHEAT SHEET
by Simon Schmid. Work in progrss, without any guarantees. Spotted a mistake? Mail [here](mailto:simon@netwings.ch).

## SETUP

### Jupyter Notebook
**`%matplotlib inline`**                      *- use command to display plots in notebooks*

### Needed Libraries
**`import matplotlib.pyplot as plt`**         *- to use everything matplotlib's functions*

**`import matplotlib.ticker as ticker`**      *- to use the formatters*

**`import matplotlib.dates as dates`**        *- to use date formatters*

### To Export Charts
**`matplotlib.rcParams['pdf.fonttype'] = 42`** *- to export in type2 fonts not type3*

## PLOTTING FROM PANDAS

### Main function
**`df.plot()`**                               *- Various kinds of plots can be done* [reference](https://pandas.pydata.org/pandas-docs/stable/generated/pandas.DataFrame.plot.html)
- `use_index=True`                      *- Index column is used as x-Axis by default*
- `x="field1", y="field2"`              *- specify x and y explicitly*
- `ax='plot'`                           *- Specity existing Plot where it should be drawn*

subplots:
- `subplots=False/True`                 *- Separate subplot for each figure*
- `sharex=False/True`                   *- For subplots: share x-Axis*
- `sharey=False/True`                   *- For subplots: share x-Axis*
- `layout=(m,n)`                        *- Layout of the subplots*

general layout options:
- `title="title"`                       *- the title*
- `figsize=(valx, valy)`                *- define size of the graph*
- `legend="True/False"`                 *- display a legend*
- `grid=False/True`                     *- Whether to display grid lines*

axis options:
- `xlim=(val1, val2)`                   *- set min and max of x-axis*
- `ylim=(val1, val2)`                   *- set min and max of y-axis*
- `logx=False/True`                     *- Use log scaling on x-axis*
- `logy=False/True`                     *- Use log scaling on y-axis*

tick options:
- `xticks=[list]`                       *- Specify the x-ticks explicitly*
- `yticks=[list]`                       *- Specify the y-ticks explicitly*
- `fontsize=number`                     *- Font size of the ticks*

### Special Plots

**`df.plot(kind='line')`**                    *- Line is default option*
- `linewidth=n`                         *- width of line*
- `alpha=number`                        *- Alpha-value of the colors*
- `color='color'`                       *- Color (can be a list)*
- `linestyle='style'`                   *- line Style*
- `marker='style'`                      *- marker style* [see list](https://stackoverflow.com/questions/8409095/matplotlib-set-markers-for-individual-points-on-a-line)

**`df.plot(kind='bar'/'barh')`**              *- Vertical/horizontal bar chart*
- `stacked=True/False`                  *- for stacked bar charts*
- `color='color'`                       *- Color (can be a list)*

**`df.plot(kind="scatter")`**                 *- scatterplot*
- `linewidth=n`                         *- width of marker line*
- `s=number`                            *- size of the dots in a scatterplot (can be a list)*
- `alpha=number`                        *- Alpha-value of the colors*
- `color='color'`                       *- Color (can be a list)*
- `marker='style'`                      *- marker style*

## PLOTTING FROM MATPLOTLIB

### Creating figures and subplot-objects
**`fig, ax = plt.subplots()`**                *- create separate handles for the figure and subplot* [reference](https://matplotlib.org/api/_as_gen/matplotlib.pyplot.subplots.html)
- `figsize=(x,y)`                       *- Specify width and heigth in inches*

**`fig, (ax1, ax2, ...) = plt.subplots(m, n)`** *- create handles for figure and several subplots*
- `sharey=True`                         *- Let them share the same y-axis*
- `sharex=True`                         *- Let them share the same x-axis*

**`fig = plt.figure()`**                      *- create only the figure seperately* [reference](https://matplotlib.org/api/_as_gen/matplotlib.pyplot.figure.html)

**`ax = fig.add_subplot(vpos, hpos, n)`**     *- add a subplot to the figure, at the nth position in a (v*h) grid*

### Drawing charts on subplot-objects
**`ax.plot()`**                               *- draw a chart on an existing subplot-object.* [Overview of types](https://matplotlib.org/2.0.2/api/axes_api.html)

**`ax.bar()`**                                *- draw a bar chart on an existing subplot-object.* [reference](https://matplotlib.org/api/_as_gen/matplotlib.pyplot.bar.html)

**`ax.barh()`**                               *- draw a horizontal bar chart on an existing subplot-object.* [reference](https://matplotlib.org/api/_as_gen/matplotlib.pyplot.barh.html)]

**`ax.scatter()`**                            *- draw a scatterplot on an existing subplot-object.* [reference](https://matplotlib.org/api/_as_gen/matplotlib.pyplot.scatter.html)

**`ax.pie()`**                                *- draw a pie chart on an existing subplot-object.*[reference](https://matplotlib.org/api/_as_gen/matplotlib.pyplot.pie.html)

**`ax.hlines()`**                             *- draw a horizontal line on an existing subplot-object.* [reference](https://matplotlib.org/api/_as_gen/matplotlib.pyplot.hlines.html)

**`ax.fill_between()`**                       *- Fill the area between y_mins and y_maxes* [reference](https://matplotlib.org/api/_as_gen/matplotlib.pyplot.fill_between.html)
- `x_values=list`
- `y_mins=list`
- `y_maxes=list`

## FORMATTING CHARTS

### Figure
**`fig.set_size_inches(x, y)`**               *- Set the sizes*

### Title
**`ax.set_title("Title")`**                   *- Set the title* [reference](https://matplotlib.org/api/_as_gen/matplotlib.axes.Axes.set_title.html)
- `loc=['center','left','right']`       *- Horizontal Location*
- `fontsize=number`                     *- Font size*
- `fontweight='fontweight'`             *- Font weight*
- `fontname='fontname'`                 *- Font name*
- `fontdict=dict`                       *- All font properties in one dictionary*

### Border
**`ax.spines['right'].set_visible(True/False)`** *- display borders around canvas* [reference](https://matplotlib.org/api/spines_api.html)
- `'left'`
- `'top'`
- `'bottom'`

### Grid
**`ax.grid(True)`**                           *- Turn on all grid*

**`ax.grid()`**                               *- Turn on grid* [reference](https://matplotlib.org/api/_as_gen/matplotlib.axes.Axes.grid.html)
- `axis='x'/'y'`                        *- Which axis*
- `which : {'major', 'minor', 'both'}`  *- Which type of gridline to format*
- `linestyle=linestyle`                 *- See link above*
- `linewidth=number`                    *- Grid line width*
- `color=color`                         *- Grid line color*

**`ax.minorticks_on()`**                      *- Required to draw minor gridlines*

### Background
**`ax.set_facecolor("color")`**               *- Set the background color*

### Axes
**`ax.set_xlim([min, max])`**                 *- set range on the x-Axis*

**`ax.set_ylim([min, max])`**                 *- Set range on the y-Axis*

**`ax.axis('off')`**                          *- remove the axes completely*

**`ax.set_xlabel("Label")`**                  *- Set label of horizontal axis*
- `fontdict=dict`                       *- Dictionary, or individual properties*
- `rotation=number`                     *- Rotation of the labels*
- `labelpad=number`                     *- Padding of label from the axis*

**`ax.set_ylabel("Label")`**                  *- Same options as for x-Axis*

**`ax.xaxis.set_label_position('bottom')`**   *- Positioning of the x-axis-label*
- `'top'`

**`ax.yaxis.set_label_position('left')`**     *- Positioning of the y-axis-label*
- `'right'`

### Ticks
**`ax.xaxis.set_ticks(listofticks)`**         *- Specify the x-ticks manually*

**`ax.yaxis.set_ticks(listofticks)`**         *- Specify the y-ticks manually*

**`ax.xaxis.set_ticks_position('top')`**      *- position of ticks on the axis*
- `'bottom'`
- `'none'`

**`ax.yaxis.set_ticks_position('left')`**     *- position of ticks on the axis*
- `'right'`
- `'none'`

**`ax.axes.set_xticklabels()`**               *- define and format the tick labels (non-time graph)*
- `fontsize=n`
- `rotation=n`

**`ax.xaxis.set_major_locator()`**            *- Arrange number of x-Ticks (identical: y-Ticks)* [examples](https://matplotlib.org/examples/ticks_and_spines/tick-locators.html)
- `dates.YearLocator()`                 *- Example: Years in a time chart*
- `dates.MonthLocator()`                *- Example: Months in a time chart*

**`ax.xaxis.set_minor_locator()`**            *- Identical for minor ticks*

**`ax.xaxis.set_major_formatter()`**          *- Format the string in the ticks.* [examples](https://matplotlib.org/gallery/ticks_and_spines/tick-formatters.html)
- `ticker.StrMethodFormatter('${x:,}')` *- An example for $60,000-style numbers*
- `ticker.PercentFormatter(xmax=5)`     *- Another example: format as percent, max 5 entries*
- `ticker.FormatStrFormatter('%0.1f')`  *- Example: Old-style floating point format*
- `dates.DateFormatter('format')`       *- Example: Date formatting*

### Legend
**`ax.legend(True)`**                         *- Switch legend on* [list of options](https://matplotlib.org/2.0.2/api/_as_gen/matplotlib.axes.Axes.legend.html#matplotlib.axes.Axes.legend)
- `fontdict=dict`                       *- Or specify each font property*
- `loc=n`                               *- 0=best, 1=up,right, 2=up,left, ...*

## EXPORTING CHARTS
**`plt.tight_layout()`**                       *- make sure the layout has no overlap in export*

**`plt.savefig("file.pdf")`**                  *- export to pdf* [reference](https://matplotlib.org/api/_as_gen/matplotlib.pyplot.savefig.html)
- `transparent=True`

**`plt.savefig("file.svg")`**                  *- export to pdf*
- `transparent=True/False`               *- Transparency*
- `bbox_inches=n/'tight'`                *- define the box*
- `pad_inches=n`                         *- padding around the figure*
