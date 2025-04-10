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
  id 1880
  arrival_time 41459.979803149385
  lifetime 1533.9947838558342
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 32
    gpu 44
    rom 19
  ]
  node [
    id 1
    label "1"
    cpu 3
    gpu 20
    rom 29
  ]
  node [
    id 2
    label "2"
    cpu 35
    gpu 30
    rom 41
  ]
  node [
    id 3
    label "3"
    cpu 32
    gpu 24
    rom 31
  ]
  node [
    id 4
    label "4"
    cpu 14
    gpu 46
    rom 17
  ]
  node [
    id 5
    label "5"
    cpu 8
    gpu 47
    rom 10
  ]
  node [
    id 6
    label "6"
    cpu 43
    gpu 21
    rom 6
  ]
  edge [
    source 0
    target 1
    bw 12
  ]
  edge [
    source 1
    target 2
    bw 38
  ]
  edge [
    source 2
    target 3
    bw 2
  ]
  edge [
    source 3
    target 4
    bw 25
  ]
  edge [
    source 4
    target 5
    bw 38
  ]
  edge [
    source 5
    target 6
    bw 1
  ]
]
