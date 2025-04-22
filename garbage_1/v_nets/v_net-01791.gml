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
  id 1791
  arrival_time 39835.99323281297
  lifetime 10.109929471092405
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 22
    gpu 28
    rom 50
  ]
  node [
    id 1
    label "1"
    cpu 40
    gpu 41
    rom 26
  ]
  node [
    id 2
    label "2"
    cpu 35
    gpu 46
    rom 15
  ]
  node [
    id 3
    label "3"
    cpu 36
    gpu 22
    rom 23
  ]
  node [
    id 4
    label "4"
    cpu 45
    gpu 10
    rom 18
  ]
  node [
    id 5
    label "5"
    cpu 43
    gpu 33
    rom 11
  ]
  node [
    id 6
    label "6"
    cpu 13
    gpu 32
    rom 12
  ]
  node [
    id 7
    label "7"
    cpu 47
    gpu 23
    rom 17
  ]
  edge [
    source 0
    target 1
    bw 23
  ]
  edge [
    source 1
    target 2
    bw 35
  ]
  edge [
    source 2
    target 3
    bw 9
  ]
  edge [
    source 3
    target 4
    bw 46
  ]
  edge [
    source 4
    target 5
    bw 49
  ]
  edge [
    source 5
    target 6
    bw 29
  ]
  edge [
    source 6
    target 7
    bw 38
  ]
]
