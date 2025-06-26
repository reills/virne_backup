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
  id 5
  arrival_time 88.86958063864307
  lifetime 131.60358462021958
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 3
    gpu 28
    rom 46
  ]
  node [
    id 1
    label "1"
    cpu 8
    gpu 23
    rom 43
  ]
  node [
    id 2
    label "2"
    cpu 40
    gpu 48
    rom 22
  ]
  node [
    id 3
    label "3"
    cpu 3
    gpu 30
    rom 44
  ]
  node [
    id 4
    label "4"
    cpu 19
    gpu 21
    rom 18
  ]
  node [
    id 5
    label "5"
    cpu 8
    gpu 9
    rom 6
  ]
  node [
    id 6
    label "6"
    cpu 42
    gpu 44
    rom 7
  ]
  node [
    id 7
    label "7"
    cpu 25
    gpu 21
    rom 47
  ]
  node [
    id 8
    label "8"
    cpu 18
    gpu 41
    rom 33
  ]
  node [
    id 9
    label "9"
    cpu 46
    gpu 15
    rom 35
  ]
  edge [
    source 0
    target 1
    bw 29
  ]
  edge [
    source 1
    target 2
    bw 37
  ]
  edge [
    source 2
    target 3
    bw 46
  ]
  edge [
    source 3
    target 4
    bw 29
  ]
  edge [
    source 4
    target 5
    bw 6
  ]
  edge [
    source 5
    target 6
    bw 32
  ]
  edge [
    source 6
    target 7
    bw 17
  ]
  edge [
    source 7
    target 8
    bw 48
  ]
  edge [
    source 8
    target 9
    bw 12
  ]
]
