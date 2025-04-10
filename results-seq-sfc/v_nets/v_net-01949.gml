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
  id 1949
  arrival_time 42827.133818327624
  lifetime 865.9732793868899
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 48
    gpu 21
    rom 2
  ]
  node [
    id 1
    label "1"
    cpu 42
    gpu 12
    rom 42
  ]
  node [
    id 2
    label "2"
    cpu 17
    gpu 44
    rom 43
  ]
  node [
    id 3
    label "3"
    cpu 24
    gpu 17
    rom 46
  ]
  node [
    id 4
    label "4"
    cpu 49
    gpu 4
    rom 22
  ]
  node [
    id 5
    label "5"
    cpu 12
    gpu 27
    rom 31
  ]
  node [
    id 6
    label "6"
    cpu 35
    gpu 12
    rom 21
  ]
  node [
    id 7
    label "7"
    cpu 12
    gpu 7
    rom 0
  ]
  edge [
    source 0
    target 1
    bw 43
  ]
  edge [
    source 1
    target 2
    bw 26
  ]
  edge [
    source 2
    target 3
    bw 22
  ]
  edge [
    source 3
    target 4
    bw 39
  ]
  edge [
    source 4
    target 5
    bw 19
  ]
  edge [
    source 5
    target 6
    bw 47
  ]
  edge [
    source 6
    target 7
    bw 47
  ]
]
