//
//  Resolver.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 01.03.23.
//

import Swinject

extension App {
    
    final class DIResolver {
        
        static func resolveDependenices() -> Assembler? {
            let tvGuideAssembly: [Assembly] = [UI.TvGuide.Assembly()]
            
            let moduleAssembler = Assembler(tvGuideAssembly, parent:  resolveInteractors())
            let assembler = Assembler([RouterAssembly()], parent: moduleAssembler)
            return assembler
        }
    }
    
    private static func resolveInteractors() -> Assembler? {
        return Assembler([InteractorAssembly()])
    }
}


