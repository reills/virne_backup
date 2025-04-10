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
  id 1871
  arrival_time 40999.52724054197
  lifetime 667.8589110946214
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 6
    gpu 18
    rom 18
  ]
  node [
    id 1
    label "1"
    cpu 21
    gpu 35
    rom 27
  ]
  node [
    id 2
    label "2"
    cpu 18
    gpu 42
    rom 21
  ]
  node [
    id 3
    label "3"
    cpu 29
    gpu 25
    rom 7
  ]
  node [
    id 4
    label "4"
    cpu 1
    gpu 45
    rom 0
  ]
  node [
    id 5
    label "5"
    cpu 38
    gpu 7
    rom 37
  ]
  node [
    id 6
    label "6"
    cpu 11
    gpu 50
    rom 33
  ]
  node [
    id 7
    label "7"
    cpu 5
    gpu 12
    rom 15
  ]
  edge [
    source 0
    target 1
    bw 36
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
    bw 6
  ]
  edge [
    source 4
    target 5
    bw 28
  ]
  edge [
    source 5
    target 6
    bw 10
  ]
  edge [
    source 6
    target 7
    bw 40
  ]
]
