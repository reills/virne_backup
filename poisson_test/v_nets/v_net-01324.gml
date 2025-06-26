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
  id 1324
  arrival_time 27671.173652226436
  lifetime 2401.387326566256
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 31
    gpu 2
    rom 29
  ]
  node [
    id 1
    label "1"
    cpu 11
    gpu 41
    rom 46
  ]
  node [
    id 2
    label "2"
    cpu 43
    gpu 50
    rom 47
  ]
  node [
    id 3
    label "3"
    cpu 23
    gpu 48
    rom 37
  ]
  node [
    id 4
    label "4"
    cpu 23
    gpu 26
    rom 21
  ]
  node [
    id 5
    label "5"
    cpu 43
    gpu 33
    rom 15
  ]
  node [
    id 6
    label "6"
    cpu 3
    gpu 8
    rom 8
  ]
  node [
    id 7
    label "7"
    cpu 29
    gpu 23
    rom 36
  ]
  node [
    id 8
    label "8"
    cpu 12
    gpu 37
    rom 11
  ]
  node [
    id 9
    label "9"
    cpu 18
    gpu 31
    rom 2
  ]
  edge [
    source 0
    target 1
    bw 39
  ]
  edge [
    source 1
    target 2
    bw 48
  ]
  edge [
    source 2
    target 3
    bw 8
  ]
  edge [
    source 3
    target 4
    bw 6
  ]
  edge [
    source 4
    target 5
    bw 49
  ]
  edge [
    source 5
    target 6
    bw 22
  ]
  edge [
    source 6
    target 7
    bw 33
  ]
  edge [
    source 7
    target 8
    bw 30
  ]
  edge [
    source 8
    target 9
    bw 0
  ]
]
