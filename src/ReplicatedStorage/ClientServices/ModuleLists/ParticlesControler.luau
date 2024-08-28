local ParticlesControler = {}

function ParticlesControler.Emit(object: Model | MeshPart): ()
    if not object then return end
    for _: number, obj: MeshPart? in object:GetChildren() do
        if not obj:IsA("Attachment") then continue end
        for _: number, particles: ParticleEmitter? in obj:GetChildren() do
            particles:Clear()
            particles:Emit()
        end
    end
end

return ParticlesControler