using LinearAlgebra
using Plots

mutable struct Particle
    position::Vector{Float64}
    mass::Float64
end


function force(p1::Particle, p2::Particle)
    r = (p2.position .- p1.position)
    return r * p1.mass * p2.mass / norm(r, 2)^3
end

function accels(plist::Vector{Particle})
    a = [zeros(size(p.position)) for p in plist]

    for (i, p) in enumerate(plist)
        for j in plist
            if p != j
                a[i] += force(p, j) / p.mass
            end
        end
    end

    return a
end

function update_particles(plist::Vector{Particle}, positions)
    for (i, _) in enumerate(plist)
        plist[i].position = positions[i]
    end
end
