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
  id 1935
  arrival_time 42652.444197709665
  lifetime 73.55597082854233
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 23
    gpu 36
    rom 7
  ]
  node [
    id 1
    label "1"
    cpu 6
    gpu 46
    rom 6
  ]
  node [
    id 2
    label "2"
    cpu 12
    gpu 20
    rom 41
  ]
  node [
    id 3
    label "3"
    cpu 28
    gpu 8
    rom 21
  ]
  node [
    id 4
    label "4"
    cpu 39
    gpu 38
    rom 2
  ]
  node [
    id 5
    label "5"
    cpu 5
    gpu 50
    rom 48
  ]
  node [
    id 6
    label "6"
    cpu 15
    gpu 50
    rom 44
  ]
  edge [
    source 0
    target 1
    bw 11
  ]
  edge [
    source 1
    target 2
    bw 24
  ]
  edge [
    source 2
    target 3
    bw 42
  ]
  edge [
    source 3
    target 4
    bw 41
  ]
  edge [
    source 4
    target 5
    bw 27
  ]
  edge [
    source 5
    target 6
    bw 48
  ]
]
