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
  id 1012
  arrival_time 21575.820182146632
  lifetime 1222.3335576663599
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 49
    gpu 43
    rom 37
  ]
  node [
    id 1
    label "1"
    cpu 26
    gpu 21
    rom 1
  ]
  node [
    id 2
    label "2"
    cpu 4
    gpu 48
    rom 45
  ]
  node [
    id 3
    label "3"
    cpu 18
    gpu 30
    rom 34
  ]
  node [
    id 4
    label "4"
    cpu 44
    gpu 39
    rom 1
  ]
  node [
    id 5
    label "5"
    cpu 29
    gpu 42
    rom 49
  ]
  node [
    id 6
    label "6"
    cpu 42
    gpu 32
    rom 33
  ]
  node [
    id 7
    label "7"
    cpu 49
    gpu 23
    rom 46
  ]
  edge [
    source 0
    target 1
    bw 28
  ]
  edge [
    source 1
    target 2
    bw 11
  ]
  edge [
    source 2
    target 3
    bw 42
  ]
  edge [
    source 3
    target 4
    bw 39
  ]
  edge [
    source 4
    target 5
    bw 4
  ]
  edge [
    source 5
    target 6
    bw 14
  ]
  edge [
    source 6
    target 7
    bw 48
  ]
]
