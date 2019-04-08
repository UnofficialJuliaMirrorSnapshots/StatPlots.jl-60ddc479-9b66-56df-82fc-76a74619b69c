@shorthands marginalhist

@recipe function f(::Type{Val{:marginalhist}}, plt::AbstractPlot; density = false)
    x, y = plotattributes[:x], plotattributes[:y]
    bns = get(plotattributes, :bins, :auto)
    edges1, edges2 = Plots._hist_edges((x,y), bns)

    # set up the subplots
    legend --> false
    link := :both
    grid --> false
    layout --> @layout [
        tophist           _
        hist2d{0.9w,0.9h} righthist
    ]

    # main histogram2d
    @series begin
        seriestype := :histogram2d
        right_margin --> 0mm
        top_margin --> 0mm
        subplot := 2
        bins := (edges1, edges2)
    end

    # these are common to both marginal histograms
    ticks := nothing
    xlabel := ""
    ylabel := ""
    foreground_color_border := nothing
    fillcolor --> Plots.fg_color(plotattributes)
    linecolor --> Plots.fg_color(plotattributes)

    if density
        trim := true
        seriestype := :density
    else
        seriestype := :histogram
    end

    # upper histogram
    @series begin
        subplot := 1
        bottom_margin --> 0mm
        bins := edges1
        y := x
    end

    # right histogram
    @series begin
        orientation := :h
        subplot := 3
        left_margin --> 0mm
        bins := edges2
        y := y
    end
end

# # now you can plot like:
# marginalhist(rand(1000), rand(1000))
