!=====================================================================
!
!               S p e c f e m 3 D  V e r s i o n  3 . 0
!               ---------------------------------------
!
!     Main historical authors: Dimitri Komatitsch and Jeroen Tromp
!                        Princeton University, USA
!                and CNRS / University of Marseille, France
!                 (there are currently many more authors!)
! (c) Princeton University and CNRS / University of Marseille, July 2012
!
! This program is free software; you can redistribute it and/or modify
! it under the terms of the GNU General Public License as published by
! the Free Software Foundation; either version 2 of the License, or
! (at your option) any later version.
!
! This program is distributed in the hope that it will be useful,
! but WITHOUT ANY WARRANTY; without even the implied warranty of
! MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
! GNU General Public License for more details.
!
! You should have received a copy of the GNU General Public License along
! with this program; if not, write to the Free Software Foundation, Inc.,
! 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
!
!=====================================================================
!
! United States and French Government Sponsorship Acknowledged.
!

  subroutine meshfem3D()

  use meshfem3D_par

  implicit none

!=============================================================================!
!                                                                             !
!  meshfem3D produces a spectral element grid for a local or regional model.  !
!  The mesher uses the UTM projection                                         !
!                                                                             !
!=============================================================================!
!
! If you use this code for your own research, please cite at least one article
! written by the developers of the package, for instance:
!
! @ARTICLE{TrKoLi08,
! author = {Jeroen Tromp and Dimitri Komatitsch and Qinya Liu},
! title = {Spectral-Element and Adjoint Methods in Seismology},
! journal = {Communications in Computational Physics},
! year = {2008},
! volume = {3},
! pages = {1-32},
! number = {1}}
!
! @ARTICLE{PeKoLuMaLeCaLeMaLiBlNiBaTr11,
! author = {Daniel Peter and Dimitri Komatitsch and Yang Luo and Roland Martin
!     and Nicolas {Le Goff} and Emanuele Casarotti and Pieyre {Le Loher}
!     and Federica Magnoni and Qinya Liu and C\'eline Blitz and Tarje Nissen-Meyer
!     and Piero Basini and Jeroen Tromp},
! title = {Forward and adjoint simulations of seismic wave propagation on fully
!     unstructured hexahedral meshes},
! journal={Geophys. J. Int.},
! year = {2011},
! volume = {186},
! pages = {721-739},
! number = {2},
! doi = {10.1111/j.1365-246X.2011.05044.x}}
!
! or
!
! @ARTICLE{LiPoKoTr04,
! author = {Qinya Liu and Jascha Polet and Dimitri Komatitsch and Jeroen Tromp},
! title = {Spectral-element moment tensor inversions for earthquakes in {S}outhern {C}alifornia},
! journal={Bull. Seismol. Soc. Am.},
! year = {2004},
! volume = {94},
! pages = {1748-1761},
! number = {5},
! doi = {10.1785/012004038}}
!
! @INCOLLECTION{ChKoViCaVaFe07,
! author = {Emmanuel Chaljub and Dimitri Komatitsch and Jean-Pierre Vilotte and
! Yann Capdeville and Bernard Valette and Gaetano Festa},
! title = {Spectral Element Analysis in Seismology},
! booktitle = {Advances in Wave Propagation in Heterogeneous Media},
! publisher = {Elsevier - Academic Press},
! year = {2007},
! editor = {Ru-Shan Wu and Val\'erie Maupin},
! volume = {48},
! series = {Advances in Geophysics},
! pages = {365-419}}
!
! @ARTICLE{KoVi98,
! author={D. Komatitsch and J. P. Vilotte},
! title={The spectral-element method: an efficient tool to simulate the seismic response of 2{D} and 3{D} geological structures},
! journal={Bull. Seismol. Soc. Am.},
! year=1998,
! volume=88,
! number=2,
! pages={368-392}}
!
! @ARTICLE{KoTr99,
! author={D. Komatitsch and J. Tromp},
! year=1999,
! title={Introduction to the spectral-element method for 3-{D} seismic wave propagation},
! journal={Geophys. J. Int.},
! volume=139,
! number=3,
! pages={806-822},
! doi={10.1046/j.1365-246x.1999.00967.x}}
!
! @ARTICLE{KoLiTrSuStSh04,
! author={Dimitri Komatitsch and Qinya Liu and Jeroen Tromp and Peter S\"{u}ss
!   and Christiane Stidham and John H. Shaw},
! year=2004,
! title={Simulations of Ground Motion in the {L}os {A}ngeles {B}asin
!   based upon the Spectral-Element Method},
! journal={Bull. Seism. Soc. Am.},
! volume=94,
! number=1,
! pages={187-206}}
!
! and/or another article from http://web.univ-pau.fr/~dkomati1/publications.html
!
!
! If you use the kernel capabilities of the code, please cite at least one article
! written by the developers of the package, for instance:
!
! @ARTICLE{TrKoLi08,
! author = {Jeroen Tromp and Dimitri Komatitsch and Qinya Liu},
! title = {Spectral-Element and Adjoint Methods in Seismology},
! journal = {Communications in Computational Physics},
! year = {2008},
! volume = {3},
! pages = {1-32},
! number = {1}}
!
! @ARTICLE{PeKoLuMaLeCaLeMaLiBlNiBaTr11,
! author = {Daniel Peter and Dimitri Komatitsch and Yang Luo and Roland Martin
!     and Nicolas {Le Goff} and Emanuele Casarotti and Pieyre {Le Loher}
!     and Federica Magnoni and Qinya Liu and C\'eline Blitz and Tarje Nissen-Meyer
!     and Piero Basini and Jeroen Tromp},
! title = {Forward and adjoint simulations of seismic wave propagation on fully
!     unstructured hexahedral meshes},
! journal={Geophys. J. Int.},
! year = {2011},
! volume = {186},
! pages = {721-739},
! number = {2},
! doi = {10.1111/j.1365-246X.2011.05044.x}}
!
! or
!
! @ARTICLE{LiTr06,
! author={Qinya Liu and Jeroen Tromp},
! title={Finite-frequency kernels based on adjoint methods},
! journal={Bull. Seismol. Soc. Am.},
! year=2006,
! volume=96,
! number=6,
! pages={2383-2397},
! doi={10.1785/0120060041}}
!
!
! Reference frame - convention:
! ----------------------------
!
! The code uses the following convention for the reference frame:
!
!  - X axis is East
!  - Y axis is North
!  - Z axis is up
!
! Note that this convention is different from both the Aki-Richards convention
! and the Harvard CMT convention.
!
! Let us recall that the Aki-Richards convention is:
!
!  - X axis is North
!  - Y axis is East
!  - Z axis is down
!
! and that the Harvard CMT convention is:
!
!  - X axis is South
!  - Y axis is East
!  - Z axis is up
!
! To report bugs or suggest improvements to the code, please send an email
! to Jeroen Tromp <jtromp AT princeton.edu> and/or use our online
! bug tracking system at http://www.geodynamics.org/roundup .
!
! Evolution of the code:
! ---------------------
!
! MPI v. 3.0, December 2014: many developers.
! Convolutional PML, LDDRK time scheme, bulk attenuation support, simultaneous MPI runs,
! ADIOS file I/O support, coupling with external codes, new seismogram names,
! Deville routines for additional GLL degrees, tomography tools, unit/regression test framework,
! improved CUDA GPUs performance, additonal GEOCUBIT support, better make compilation,
! git versioning system.
!
! MPI v. 2.1, July 2012:
! Max Rietmann, Peter Messmer, Daniel Peter, Dimitri Komatitsch, Joseph Charles, Zhinan Xie:
! support for CUDA GPUs, better CFL stability for the Stacey absorbing conditions.
!
! MPI v. 2.0, November 2010:
! Dimitri Komatitsch, Nicolas Le Goff, Roland Martin and Pieyre Le Loher, University of Pau, France,
! Daniel Peter, Jeroen Tromp and the Princeton group of developers, Princeton University, USA,
! and Emanuele Casarotti, INGV Roma, Italy:
!  support for CUBIT meshes decomposed by SCOTCH;
!  much faster solver using Michel Deville's inlined matrix products.
!
! MPI v. 1.4 Dimitri Komatitsch, University of Pau, Qinya Liu and others, Caltech, September 2006:
!  better adjoint and kernel calculations, faster and better I/Os
!  on very large systems, many small improvements and bug fixes
!
! MPI v. 1.3 Dimitri Komatitsch, University of Pau, and Qinya Liu, Caltech, July 2005:
!  serial version, regular mesh, adjoint and kernel calculations, ParaView support
!
! MPI v. 1.2 Min Chen and Dimitri Komatitsch, Caltech, July 2004:
!  full anisotropy, volume movie
!
! MPI v. 1.1 Dimitri Komatitsch, Caltech, October 2002: Zhu's Moho map, scaling
!  of Vs with depth, Hauksson's regional model, attenuation, oceans, movies
!
! MPI v. 1.0 Dimitri Komatitsch, Caltech, USA, May 2002: first MPI version based on global code
!
! Dimitri Komatitsch, IPG Paris, France, December 1996: first 3-D solver for the CM-5 Connection Machine,
!    parallelized on 128 processors using Connection Machine Fortran
!

! local parameters
  integer :: iprocnum
  integer :: iproc_xi,iproc_eta
  integer :: ier

  ! interface parameters
  integer :: ilayer

  ! timer MPI
  double precision, external :: wtime
  double precision :: time_start,tCPU

! ************** PROGRAM STARTS HERE **************

  ! sizeprocs returns number of processes started (should be equal to NPROC).
  ! myrank is the rank of each process, between 0 and NPROC-1.
  ! as usual in MPI, process 0 is in charge of coordinating everything
  ! and also takes care of the main output
  call world_size(sizeprocs)
  call world_rank(myrank)

  ! open main output file, only written to by process 0
  if (myrank == 0 .and. IMAIN /= ISTANDARD_OUTPUT) then
    open(unit=IMAIN,file=trim(OUTPUT_FILES)//'/output_meshfem3D.txt',status='unknown',iostat=ier)
    if (ier /= 0) then
      print *,'Error could not open output file :',trim(OUTPUT_FILES)//'/output_meshfem3D.txt'
      stop 'Error opening output file'
    endif
  endif

  ! get MPI starting time
  time_start = wtime()

  if (myrank == 0) then
    write(IMAIN,*)
    write(IMAIN,*) '******************************************'
    write(IMAIN,*) '*** Specfem3D MPI meshfem3D - f90 version ***'
    write(IMAIN,*) '******************************************'
    write(IMAIN,*)
    call flush_IMAIN()
  endif

  ! read the parameter file (DATA/Par_file)
  BROADCAST_AFTER_READ = .true.
  call read_parameter_file(myrank,BROADCAST_AFTER_READ)

  ! make sure everybody is synchronized
  call synchronize_all()

  ! if meshing a chunk of the Earth, call a specific internal mesher designed specifically for that
  ! CD CD change this to have also the possibility to use a chunk without coupling
  if (MESH_A_CHUNK_OF_THE_EARTH) then
    ! user output
    if (myrank == 0) then
      write(IMAIN,*)
      write(IMAIN,*) 'creating chunk of the Earth mesh'
      write(IMAIN,*)
      call flush_IMAIN()
    endif

    if (NGNOD == 8) then
      ! creates mesh in MESH/
      call earth_chunk_HEX8_Mesher(NGNOD)
      ! done with mesher
      stop 'Done creating a chunk of the earth Mesh (HEX8 elements), see directory MESH/'

    else if (NGNOD == 27) then

      ! creates mesh in MESH/
      call earth_chunk_HEX27_Mesher(NGNOD)
      ! done with mesher
      stop 'Done creating a chunk of the earth Mesh (HEX27 elements), see directory MESH/'

    else
      stop 'Bad number of nodes per hexahedron : NGNOD must be equal to 8 or 27'
    endif

    ! make sure everybody is synchronized
    call synchronize_all()
  endif

  ! read the mesh parameter file (Data/meshfem3D_files/Mesh_Par_file)
  ! nullify(subregions,material_properties)
  call read_mesh_parameter_file()

  ! get interface data from external file to count the spectral elements along Z
  call get_interfaces_mesh_count()

  ! compute total number of spectral elements in vertical direction
  NER = sum(ner_layer)

  ! checks if regions and vertical layers from interfaces file match
  if (maxval(subregions(:,6)) /= NER) then
    print *,'Error invalid total number of element layers in vertical direction!'
    print *,'from interface file, total layers = ',NER
    print *,'should be equal to maximum layer NZ_END specified in regions:', maxval(subregions(:,6))
    stop 'Error invalid total number of vertical layers'
  endif

  ! checks irregular grid entries
  if (.not. USE_REGULAR_MESH) then
    if (maxval(ner_doublings(:)) == NER) then
      print *,'Error invalid doubling layer NZ index too close to surface layer ',NER
      print *,'Please decrease maximum doubling layer index NZ_DOUBLING'
      stop 'Error invalid doubling layer index too close to surface layer'
    endif
  endif


  ! compute other parameters based upon values read
  call compute_parameters(NER,NEX_XI,NEX_ETA,NPROC_XI,NPROC_ETA, &
                          NPROC,NEX_PER_PROC_XI,NEX_PER_PROC_ETA, &
                          NSPEC_AB,NSPEC2D_A_XI,NSPEC2D_B_XI, &
                          NSPEC2D_A_ETA,NSPEC2D_B_ETA, &
                          NSPEC2DMAX_XMIN_XMAX,NSPEC2DMAX_YMIN_YMAX,NSPEC2D_BOTTOM,NSPEC2D_TOP, &
                          NPOIN2DMAX_XMIN_XMAX,NPOIN2DMAX_YMIN_YMAX,NGLOB_AB,&
                          USE_REGULAR_MESH,NDOUBLINGS,ner_doublings)

  ! check that the code is running with the requested nb of processes
  if (sizeprocs /= NPROC) then
    if (myrank == 0) then
      write(IMAIN,*) 'Error: number of processors supposed to run on: ',NPROC
      write(IMAIN,*) 'Error: number of MPI processors actually run on: ',sizeprocs
      print *
      print *, 'Error meshfem3D: number of processors supposed to run on: ',NPROC
      print *, 'Error meshfem3D: number of MPI processors actually run on: ',sizeprocs
      print *
    endif
    call exit_MPI(myrank,'wrong number of MPI processes')
  endif

  ! dynamic allocation of mesh arrays
  allocate(rns(0:2*NER),stat=ier)
  if (ier /= 0) stop 'Error allocating array rns'

  allocate(xgrid(0:2*NER,0:2*NEX_PER_PROC_XI,0:2*NEX_PER_PROC_ETA),stat=ier)
  if (ier /= 0) stop 'Error allocating array xgrid'
  allocate(ygrid(0:2*NER,0:2*NEX_PER_PROC_XI,0:2*NEX_PER_PROC_ETA),stat=ier)
  if (ier /= 0) stop 'Error allocating array ygrid'
  allocate(zgrid(0:2*NER,0:2*NEX_PER_PROC_XI,0:2*NEX_PER_PROC_ETA),stat=ier)
  if (ier /= 0) call exit_MPI(myrank,'not enough memory to allocate arrays')

  allocate(addressing(0:NPROC_XI-1,0:NPROC_ETA-1),stat=ier)
  if (ier /= 0) stop 'Error allocating array addressing'
  allocate(iproc_xi_slice(0:NPROC-1),stat=ier)
  if (ier /= 0) stop 'Error allocating array iproc_xi_slice'
  allocate(iproc_eta_slice(0:NPROC-1),stat=ier)
  if (ier /= 0) stop 'Error allocating array iproc_eta_slice'

  ! clear arrays
  xgrid(:,:,:) = 0.d0
  ygrid(:,:,:) = 0.d0
  zgrid(:,:,:) = 0.d0

  iproc_xi_slice(:) = 0
  iproc_eta_slice(:) = 0

  ! create global slice addressing for solver
  if (myrank == 0) then
    write(IMAIN,*)
    write(IMAIN,*) 'Creating global slice addressing'
    write(IMAIN,*)
    call flush_IMAIN()
  endif

  do iproc_eta = 0,NPROC_ETA-1
    do iproc_xi = 0,NPROC_XI-1
      iprocnum = iproc_eta * NPROC_XI + iproc_xi
      iproc_xi_slice(iprocnum) = iproc_xi
      iproc_eta_slice(iprocnum) = iproc_eta
      addressing(iproc_xi,iproc_eta) = iprocnum
    enddo
  enddo

  if (myrank == 0) then
    write(IMAIN,*) 'Spatial distribution of slice numbers:'
    do iproc_eta = NPROC_ETA-1, 0, -1
      do iproc_xi = 0, NPROC_XI-1, 1
        write(IMAIN,'(i5)',advance='no') addressing(iproc_xi,iproc_eta)
      enddo
      write(IMAIN,'(a1)',advance='yes') ' '
    enddo
    call flush_IMAIN()
  endif

  if (myrank == 0) then
    write(IMAIN,*) 'This is process ',myrank
    write(IMAIN,*) 'There are ',sizeprocs,' MPI processes'
    write(IMAIN,*) 'Processes are numbered from 0 to ',sizeprocs-1
    write(IMAIN,*)
    write(IMAIN,*) 'There are ',NEX_XI,' elements along xi'
    write(IMAIN,*) 'There are ',NEX_ETA,' elements along eta'
    write(IMAIN,*) 'There are ',NER,' elements along Z'
    write(IMAIN,*)
    do ilayer = 1,number_of_layers
       write(IMAIN,*) 'There are ',ner_layer(ilayer),' spectral elements along Z in layer ',ilayer
    enddo
    write(IMAIN,*)
    write(IMAIN,*) 'There are ',NPROC_XI,' slices along xi'
    write(IMAIN,*) 'There are ',NPROC_ETA,' slices along eta'
    write(IMAIN,*) 'There is a total of ',NPROC,' slices'

    write(IMAIN,*)
    write(IMAIN,*) 'Shape functions defined by NGNOD = ',NGNOD_EIGHT_CORNERS,' control nodes'
    write(IMAIN,*) 'Surface shape functions defined by NGNOD2D = ',NGNOD2D_FOUR_CORNERS,' control nodes'
    write(IMAIN,*) 'Beware! Curvature (i.e. HEX27 elements) is not handled by our internal mesher'
    write(IMAIN,*)
    call flush_IMAIN()
  endif

  ! check that the constants.h file is correct
  if (NGNOD /= 8) call exit_MPI(myrank,'volume elements should have 8 control nodes in our internal mesher')
  if (NGNOD2D /= 4) call exit_MPI(myrank,'surface elements should have 4 control nodes in our internal mesher')

  ! check that reals are either 4 or 8 bytes
  if (CUSTOM_REAL /= SIZE_REAL .and. CUSTOM_REAL /= SIZE_DOUBLE) call exit_MPI(myrank,'wrong size of CUSTOM_REAL for reals')

  ! for the number of standard linear solids for attenuation
  if (N_SLS /= 3) call exit_MPI(myrank,'number of SLS must be 3')

  ! check that number of slices is at least 1 in each direction
  if (NPROC_XI < 1) call exit_MPI(myrank,'NPROC_XI must be greater than 1')
  if (NPROC_ETA < 1) call exit_MPI(myrank,'NPROC_ETA must be greater than 1')

  ! check that mesh can be cut into the right number of slices
  if (mod(NEX_XI,NPROC_XI) /= 0) call exit_MPI(myrank,'NEX_XI must be a multiple of NPROC_XI for a regular mesh')
  if (mod(NEX_ETA,NPROC_ETA) /= 0) call exit_MPI(myrank,'NEX_ETA must be a multiple of NPROC_ETA for a regular mesh')

  ! also check that mesh can be coarsened in depth twice (block size multiple of 8)
  ! i.e. check that NEX is divisible by 8 and that NEX_PER_PROC is divisible by 8
  ! This is not required for a regular mesh
  if (.not. USE_REGULAR_MESH) then
    if (mod(NEX_XI,8) /= 0) call exit_MPI(myrank,'NEX_XI must be a multiple of 8')
    if (mod(NEX_ETA,8) /= 0) call exit_MPI(myrank,'NEX_ETA must be a multiple of 8')

    if (mod(NEX_PER_PROC_XI,8) /= 0) call exit_MPI(myrank,'NEX_PER_PROC_XI must be a multiple of 8')
    if (mod(NEX_PER_PROC_ETA,8) /= 0) call exit_MPI(myrank,'NEX_PER_PROC_ETA must be a multiple of 8')

    if (mod(NEX_PER_PROC_XI, 2**NDOUBLINGS * 2) /= 0 ) &
      call exit_MPI(myrank,'NEX_PER_PROC_XI must be a multiple of 2 * 2**NDOUBLINGS')
    if (mod(NEX_PER_PROC_ETA, 2**NDOUBLINGS * 2) /= 0 ) &
      call exit_MPI(myrank,'NEX_PER_PROC_ETA must be a multiple of 2 * 2**NDOUBLINGS')
  endif

  if (myrank == 0) then
    write(IMAIN,*) 'region selected:'
    write(IMAIN,*)
    write(IMAIN,*) 'latitude min = ',LATITUDE_MIN
    write(IMAIN,*) 'latitude max = ',LATITUDE_MAX
    write(IMAIN,*)
    write(IMAIN,*) 'longitude min = ',LONGITUDE_MIN
    write(IMAIN,*) 'longitude max = ',LONGITUDE_MAX
    write(IMAIN,*)
    if (SUPPRESS_UTM_PROJECTION) then
      write(IMAIN,*) 'this is given directly as UTM'
    else
      write(IMAIN,*) 'this is mapped to UTM in region ',UTM_PROJECTION_ZONE
    endif
    write(IMAIN,*)
    write(IMAIN,*) 'UTM X min = ',UTM_X_MIN
    write(IMAIN,*) 'UTM X max = ',UTM_X_MAX
    write(IMAIN,*)
    write(IMAIN,*) 'UTM Y min = ',UTM_Y_MIN
    write(IMAIN,*) 'UTM Y max = ',UTM_Y_MAX
    write(IMAIN,*)
    write(IMAIN,*) 'UTM size of model along X is ',(UTM_X_MAX-UTM_X_MIN)/1000.,' km'
    write(IMAIN,*) 'UTM size of model along Y is ',(UTM_Y_MAX-UTM_Y_MIN)/1000.,' km'
    write(IMAIN,*)
    write(IMAIN,*) 'Bottom of the mesh is at a depth of ',dabs(Z_DEPTH_BLOCK)/1000.,' km'
    write(IMAIN,*)
    write(IMAIN,*)
    if (SUPPRESS_UTM_PROJECTION) then
      write(IMAIN,*) 'suppressing UTM projection'
    else
      write(IMAIN,*) 'using UTM projection in region ',UTM_PROJECTION_ZONE
    endif
     if(PML_CONDITIONS) then
       write(IMAIN,*)
       write(IMAIN,*) 'PML thickness in X direction = ',THICKNESS_OF_X_PML,'m'
       write(IMAIN,*) 'PML thickness in Y direction = ',THICKNESS_OF_Y_PML,'m'
       write(IMAIN,*) 'PML thickness in Z direction = ',THICKNESS_OF_Z_PML,'m'
    endif
    write(IMAIN,*)
    call flush_IMAIN()
  endif

  ! get addressing for this process
  iproc_xi_current = iproc_xi_slice(myrank)
  iproc_eta_current = iproc_eta_slice(myrank)

  ! number of elements in each slice
  npx_element_steps = 2*NEX_PER_PROC_XI
  npy_element_steps = 2*NEX_PER_PROC_ETA
  ner_layer(:) = 2 * ner_layer(:)

  !min_elevation = +HUGEVAL
  !max_elevation = -HUGEVAL

  ! user output
  if (myrank == 0) then
    write(IMAIN,*)
    write(IMAIN,*) '**************************'
    write(IMAIN,*) 'Creating interfaces'
    write(IMAIN,*) '**************************'
    write(IMAIN,*)
    call flush_IMAIN()
  endif

  ! creates mesh interfaces
  call create_interfaces_mesh()

  ! user output
  if (myrank == 0) then
    write(IMAIN,*)
    write(IMAIN,*) '**************************'
    write(IMAIN,*) 'Creating mesh in the model'
    write(IMAIN,*) '**************************'
    write(IMAIN,*)
    call flush_IMAIN()
  endif

  ! creates mesh element points
  call create_meshfem_mesh()

  ! make sure everybody is synchronized
  call synchronize_all()

  !--- print number of points and elements in the mesh
  if (myrank == 0) then
    write(IMAIN,*)
    write(IMAIN,*) 'Repartition of elements:'
    write(IMAIN,*) '-----------------------'
    write(IMAIN,*)
    write(IMAIN,*) 'total number of elements in mesh slice 0: ',NSPEC_AB
    write(IMAIN,*) 'total number of points in mesh slice 0: ',NGLOB_AB
    write(IMAIN,*)
    write(IMAIN,*) 'total number of elements in entire mesh: ',NSPEC_AB*NPROC
    ! the float() statements here are for the case of more than 2 Gigapoints per mesh, in which
    ! case and integer(kind=4) counter would overflow and display an incorrect negative value;
    ! converting it to float fixes the problem (but then prints some extra decimals equal to zero).
    ! Another option would be to declare the sum as integer(kind=8) and then print it.
    write(IMAIN,*) 'approximate total number of points in entire mesh (with duplicates on MPI edges): ', &
                                             dble(NGLOB_AB)*dble(NPROC)
    write(IMAIN,*) 'approximate total number of DOFs in entire mesh (with duplicates on MPI edges): ', &
                                             dble(NGLOB_AB)*dble(NPROC*NDIM)
    write(IMAIN,*)
    ! write information about precision used for floating-point operations
    if (CUSTOM_REAL == SIZE_REAL) then
      write(IMAIN,*) 'using single precision for the calculations'
    else
      write(IMAIN,*) 'using double precision for the calculations'
    endif
    write(IMAIN,*)
    write(IMAIN,*) 'smallest and largest possible floating-point numbers are: ',tiny(1._CUSTOM_REAL),huge(1._CUSTOM_REAL)
    write(IMAIN,*)
    call flush_IMAIN()
  endif   ! end of section executed by main process only

  ! elapsed time since beginning of mesh generation
  if (myrank == 0) then
    tCPU = wtime() - time_start
    write(IMAIN,*)
    write(IMAIN,*) 'Elapsed time for mesh generation and buffer creation in seconds = ',tCPU
    write(IMAIN,*) 'End of mesh generation'
    write(IMAIN,*)
    write(IMAIN,*) 'done'
    write(IMAIN,*)
    call flush_IMAIN()

    ! close main output file
    close(IMAIN)
  endif

  ! synchronize all the processes to make sure everybody has finished
  call synchronize_all()

  end subroutine meshfem3D

