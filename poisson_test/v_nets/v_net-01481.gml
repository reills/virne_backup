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
  id 1481
  arrival_time 32181.08818880946
  lifetime 397.0299240024037
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 46
    gpu 24
    rom 33
  ]
  node [
    id 1
    label "1"
    cpu 44
    gpu 9
    rom 2
  ]
  node [
    id 2
    label "2"
    cpu 18
    gpu 21
    rom 43
  ]
  node [
    id 3
    label "3"
    cpu 32
    gpu 45
    rom 20
  ]
  node [
    id 4
    label "4"
    cpu 50
    gpu 32
    rom 15
  ]
  node [
    id 5
    label "5"
    cpu 42
    gpu 43
    rom 6
  ]
  node [
    id 6
    label "6"
    cpu 17
    gpu 43
    rom 31
  ]
  node [
    id 7
    label "7"
    cpu 20
    gpu 37
    rom 30
  ]
  node [
    id 8
    label "8"
    cpu 34
    gpu 19
    rom 11
  ]
  edge [
    source 0
    target 1
    bw 46
  ]
  edge [
    source 1
    target 2
    bw 29
  ]
  edge [
    source 2
    target 3
    bw 37
  ]
  edge [
    source 3
    target 4
    bw 26
  ]
  edge [
    source 4
    target 5
    bw 33
  ]
  edge [
    source 5
    target 6
    bw 30
  ]
  edge [
    source 6
    target 7
    bw 9
  ]
  edge [
    source 7
    target 8
    bw 10
  ]
]
