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
  id 220
  arrival_time 4058.7693998755526
  lifetime 2.154256786909056
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 29
    gpu 28
    rom 34
  ]
  node [
    id 1
    label "1"
    cpu 26
    gpu 19
    rom 4
  ]
  node [
    id 2
    label "2"
    cpu 45
    gpu 5
    rom 25
  ]
  node [
    id 3
    label "3"
    cpu 41
    gpu 21
    rom 4
  ]
  node [
    id 4
    label "4"
    cpu 23
    gpu 23
    rom 12
  ]
  node [
    id 5
    label "5"
    cpu 39
    gpu 46
    rom 35
  ]
  node [
    id 6
    label "6"
    cpu 8
    gpu 2
    rom 40
  ]
  node [
    id 7
    label "7"
    cpu 30
    gpu 49
    rom 32
  ]
  edge [
    source 0
    target 1
    bw 9
  ]
  edge [
    source 1
    target 2
    bw 26
  ]
  edge [
    source 2
    target 3
    bw 6
  ]
  edge [
    source 3
    target 4
    bw 41
  ]
  edge [
    source 4
    target 5
    bw 42
  ]
  edge [
    source 5
    target 6
    bw 14
  ]
  edge [
    source 6
    target 7
    bw 43
  ]
]
