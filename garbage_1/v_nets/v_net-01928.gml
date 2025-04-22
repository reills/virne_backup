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
  id 1928
  arrival_time 42218.00799198037
  lifetime 492.4522683284914
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 3
    gpu 24
    rom 45
  ]
  node [
    id 1
    label "1"
    cpu 41
    gpu 49
    rom 0
  ]
  node [
    id 2
    label "2"
    cpu 18
    gpu 40
    rom 2
  ]
  node [
    id 3
    label "3"
    cpu 35
    gpu 20
    rom 13
  ]
  node [
    id 4
    label "4"
    cpu 35
    gpu 19
    rom 9
  ]
  node [
    id 5
    label "5"
    cpu 50
    gpu 0
    rom 35
  ]
  node [
    id 6
    label "6"
    cpu 25
    gpu 12
    rom 21
  ]
  node [
    id 7
    label "7"
    cpu 15
    gpu 28
    rom 23
  ]
  edge [
    source 0
    target 1
    bw 19
  ]
  edge [
    source 1
    target 2
    bw 16
  ]
  edge [
    source 2
    target 3
    bw 3
  ]
  edge [
    source 3
    target 4
    bw 18
  ]
  edge [
    source 4
    target 5
    bw 38
  ]
  edge [
    source 5
    target 6
    bw 28
  ]
  edge [
    source 6
    target 7
    bw 23
  ]
]
