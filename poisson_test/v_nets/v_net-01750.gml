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
  id 1750
  arrival_time 39017.194307604725
  lifetime 221.78970443749685
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 23
    gpu 5
    rom 50
  ]
  node [
    id 1
    label "1"
    cpu 35
    gpu 38
    rom 38
  ]
  node [
    id 2
    label "2"
    cpu 30
    gpu 4
    rom 32
  ]
  node [
    id 3
    label "3"
    cpu 20
    gpu 43
    rom 19
  ]
  node [
    id 4
    label "4"
    cpu 34
    gpu 33
    rom 47
  ]
  node [
    id 5
    label "5"
    cpu 26
    gpu 12
    rom 41
  ]
  edge [
    source 0
    target 1
    bw 6
  ]
  edge [
    source 1
    target 2
    bw 21
  ]
  edge [
    source 2
    target 3
    bw 45
  ]
  edge [
    source 3
    target 4
    bw 34
  ]
  edge [
    source 4
    target 5
    bw 41
  ]
]
