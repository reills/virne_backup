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
  id 1897
  arrival_time 41912.51827264801
  lifetime 398.23914880444
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 18
    gpu 18
    rom 1
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 22
    rom 12
  ]
  node [
    id 2
    label "2"
    cpu 48
    gpu 9
    rom 31
  ]
  node [
    id 3
    label "3"
    cpu 0
    gpu 22
    rom 24
  ]
  node [
    id 4
    label "4"
    cpu 42
    gpu 2
    rom 30
  ]
  node [
    id 5
    label "5"
    cpu 3
    gpu 39
    rom 48
  ]
  node [
    id 6
    label "6"
    cpu 10
    gpu 46
    rom 5
  ]
  node [
    id 7
    label "7"
    cpu 5
    gpu 18
    rom 7
  ]
  edge [
    source 0
    target 1
    bw 45
  ]
  edge [
    source 1
    target 2
    bw 37
  ]
  edge [
    source 2
    target 3
    bw 39
  ]
  edge [
    source 3
    target 4
    bw 8
  ]
  edge [
    source 4
    target 5
    bw 29
  ]
  edge [
    source 5
    target 6
    bw 0
  ]
  edge [
    source 6
    target 7
    bw 11
  ]
]
