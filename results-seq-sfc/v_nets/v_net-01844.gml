graph [
  node_attrs_setting [
    name "cpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "gpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "rom"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  link_attrs_setting "_networkx_list_start"
  link_attrs_setting [
    name "bw"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "link"
    type "resource"
  ]
  id 1844
  arrival_time 40704.45336246513
  lifetime 460.6710522927249
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 26
    rom 15
  ]
  node [
    id 1
    label "1"
    cpu 0
    gpu 45
    rom 19
  ]
  node [
    id 2
    label "2"
    cpu 11
    gpu 20
    rom 27
  ]
  node [
    id 3
    label "3"
    cpu 29
    gpu 20
    rom 44
  ]
  node [
    id 4
    label "4"
    cpu 28
    gpu 46
    rom 1
  ]
  node [
    id 5
    label "5"
    cpu 45
    gpu 33
    rom 18
  ]
  node [
    id 6
    label "6"
    cpu 24
    gpu 28
    rom 8
  ]
  node [
    id 7
    label "7"
    cpu 13
    gpu 47
    rom 22
  ]
  node [
    id 8
    label "8"
    cpu 27
    gpu 7
    rom 33
  ]
  node [
    id 9
    label "9"
    cpu 30
    gpu 19
    rom 44
  ]
  node [
    id 10
    label "10"
    cpu 10
    gpu 40
    rom 8
  ]
  node [
    id 11
    label "11"
    cpu 2
    gpu 19
    rom 31
  ]
  node [
    id 12
    label "12"
    cpu 14
    gpu 44
    rom 0
  ]
  node [
    id 13
    label "13"
    cpu 0
    gpu 23
    rom 38
  ]
  node [
    id 14
    label "14"
    cpu 34
    gpu 24
    rom 47
  ]
  edge [
    source 0
    target 1
    bw 10
  ]
  edge [
    source 1
    target 2
    bw 11
  ]
  edge [
    source 2
    target 3
    bw 18
  ]
  edge [
    source 3
    target 4
    bw 28
  ]
  edge [
    source 4
    target 5
    bw 38
  ]
  edge [
    source 5
    target 6
    bw 27
  ]
  edge [
    source 6
    target 7
    bw 13
  ]
  edge [
    source 7
    target 8
    bw 6
  ]
  edge [
    source 8
    target 9
    bw 13
  ]
  edge [
    source 9
    target 10
    bw 48
  ]
  edge [
    source 10
    target 11
    bw 25
  ]
  edge [
    source 11
    target 12
    bw 34
  ]
  edge [
    source 12
    target 13
    bw 18
  ]
  edge [
    source 13
    target 14
    bw 44
  ]
]
