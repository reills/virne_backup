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
  id 1381
  arrival_time 29221.83895766292
  lifetime 347.09367450300266
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 37
    gpu 23
    rom 45
  ]
  node [
    id 1
    label "1"
    cpu 30
    gpu 12
    rom 12
  ]
  node [
    id 2
    label "2"
    cpu 42
    gpu 0
    rom 13
  ]
  node [
    id 3
    label "3"
    cpu 7
    gpu 18
    rom 9
  ]
  node [
    id 4
    label "4"
    cpu 7
    gpu 44
    rom 41
  ]
  node [
    id 5
    label "5"
    cpu 0
    gpu 9
    rom 6
  ]
  node [
    id 6
    label "6"
    cpu 35
    gpu 12
    rom 30
  ]
  node [
    id 7
    label "7"
    cpu 45
    gpu 39
    rom 36
  ]
  node [
    id 8
    label "8"
    cpu 20
    gpu 43
    rom 27
  ]
  node [
    id 9
    label "9"
    cpu 30
    gpu 22
    rom 48
  ]
  node [
    id 10
    label "10"
    cpu 25
    gpu 46
    rom 28
  ]
  node [
    id 11
    label "11"
    cpu 40
    gpu 48
    rom 0
  ]
  edge [
    source 0
    target 1
    bw 18
  ]
  edge [
    source 1
    target 2
    bw 27
  ]
  edge [
    source 2
    target 3
    bw 0
  ]
  edge [
    source 3
    target 4
    bw 0
  ]
  edge [
    source 4
    target 5
    bw 24
  ]
  edge [
    source 5
    target 6
    bw 17
  ]
  edge [
    source 6
    target 7
    bw 5
  ]
  edge [
    source 7
    target 8
    bw 47
  ]
  edge [
    source 8
    target 9
    bw 17
  ]
  edge [
    source 9
    target 10
    bw 28
  ]
  edge [
    source 10
    target 11
    bw 35
  ]
]
