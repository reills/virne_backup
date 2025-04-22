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
  id 1972
  arrival_time 42992.00355629502
  lifetime 230.4193644856166
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 22
    gpu 2
    rom 18
  ]
  node [
    id 1
    label "1"
    cpu 25
    gpu 39
    rom 16
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 36
    rom 6
  ]
  node [
    id 3
    label "3"
    cpu 38
    gpu 34
    rom 1
  ]
  node [
    id 4
    label "4"
    cpu 34
    gpu 43
    rom 21
  ]
  node [
    id 5
    label "5"
    cpu 32
    gpu 5
    rom 49
  ]
  node [
    id 6
    label "6"
    cpu 0
    gpu 44
    rom 49
  ]
  node [
    id 7
    label "7"
    cpu 42
    gpu 49
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 27
  ]
  edge [
    source 1
    target 2
    bw 17
  ]
  edge [
    source 2
    target 3
    bw 31
  ]
  edge [
    source 3
    target 4
    bw 22
  ]
  edge [
    source 4
    target 5
    bw 43
  ]
  edge [
    source 5
    target 6
    bw 30
  ]
  edge [
    source 6
    target 7
    bw 1
  ]
]
