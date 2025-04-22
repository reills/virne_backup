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
  id 204
  arrival_time 3600.907549661686
  lifetime 1532.2914851590078
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 0
    rom 37
  ]
  node [
    id 1
    label "1"
    cpu 50
    gpu 23
    rom 28
  ]
  node [
    id 2
    label "2"
    cpu 29
    gpu 25
    rom 36
  ]
  node [
    id 3
    label "3"
    cpu 32
    gpu 33
    rom 0
  ]
  node [
    id 4
    label "4"
    cpu 11
    gpu 37
    rom 46
  ]
  node [
    id 5
    label "5"
    cpu 41
    gpu 26
    rom 17
  ]
  node [
    id 6
    label "6"
    cpu 50
    gpu 34
    rom 23
  ]
  node [
    id 7
    label "7"
    cpu 43
    gpu 10
    rom 4
  ]
  edge [
    source 0
    target 1
    bw 4
  ]
  edge [
    source 1
    target 2
    bw 24
  ]
  edge [
    source 2
    target 3
    bw 28
  ]
  edge [
    source 3
    target 4
    bw 41
  ]
  edge [
    source 4
    target 5
    bw 25
  ]
  edge [
    source 5
    target 6
    bw 27
  ]
  edge [
    source 6
    target 7
    bw 4
  ]
]
