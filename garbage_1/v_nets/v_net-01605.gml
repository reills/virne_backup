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
  id 1605
  arrival_time 35928.962351363785
  lifetime 276.65429399463216
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 21
    gpu 19
    rom 0
  ]
  node [
    id 1
    label "1"
    cpu 43
    gpu 37
    rom 17
  ]
  node [
    id 2
    label "2"
    cpu 5
    gpu 16
    rom 43
  ]
  node [
    id 3
    label "3"
    cpu 19
    gpu 11
    rom 34
  ]
  node [
    id 4
    label "4"
    cpu 30
    gpu 42
    rom 13
  ]
  node [
    id 5
    label "5"
    cpu 42
    gpu 41
    rom 44
  ]
  node [
    id 6
    label "6"
    cpu 50
    gpu 45
    rom 11
  ]
  node [
    id 7
    label "7"
    cpu 20
    gpu 39
    rom 47
  ]
  node [
    id 8
    label "8"
    cpu 27
    gpu 41
    rom 6
  ]
  node [
    id 9
    label "9"
    cpu 10
    gpu 49
    rom 24
  ]
  node [
    id 10
    label "10"
    cpu 40
    gpu 4
    rom 10
  ]
  edge [
    source 0
    target 1
    bw 3
  ]
  edge [
    source 1
    target 2
    bw 45
  ]
  edge [
    source 2
    target 3
    bw 16
  ]
  edge [
    source 3
    target 4
    bw 12
  ]
  edge [
    source 4
    target 5
    bw 50
  ]
  edge [
    source 5
    target 6
    bw 12
  ]
  edge [
    source 6
    target 7
    bw 0
  ]
  edge [
    source 7
    target 8
    bw 2
  ]
  edge [
    source 8
    target 9
    bw 21
  ]
  edge [
    source 9
    target 10
    bw 19
  ]
]
