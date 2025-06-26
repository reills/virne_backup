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
  id 1387
  arrival_time 29326.928781465158
  lifetime 1586.3545920970264
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 10
    gpu 47
    rom 42
  ]
  node [
    id 1
    label "1"
    cpu 37
    gpu 11
    rom 18
  ]
  node [
    id 2
    label "2"
    cpu 48
    gpu 10
    rom 20
  ]
  node [
    id 3
    label "3"
    cpu 7
    gpu 29
    rom 39
  ]
  node [
    id 4
    label "4"
    cpu 25
    gpu 4
    rom 26
  ]
  node [
    id 5
    label "5"
    cpu 43
    gpu 1
    rom 9
  ]
  node [
    id 6
    label "6"
    cpu 1
    gpu 5
    rom 38
  ]
  node [
    id 7
    label "7"
    cpu 8
    gpu 0
    rom 33
  ]
  node [
    id 8
    label "8"
    cpu 28
    gpu 26
    rom 20
  ]
  node [
    id 9
    label "9"
    cpu 19
    gpu 43
    rom 4
  ]
  node [
    id 10
    label "10"
    cpu 24
    gpu 17
    rom 18
  ]
  node [
    id 11
    label "11"
    cpu 37
    gpu 28
    rom 24
  ]
  edge [
    source 0
    target 1
    bw 50
  ]
  edge [
    source 1
    target 2
    bw 2
  ]
  edge [
    source 2
    target 3
    bw 42
  ]
  edge [
    source 3
    target 4
    bw 39
  ]
  edge [
    source 4
    target 5
    bw 34
  ]
  edge [
    source 5
    target 6
    bw 44
  ]
  edge [
    source 6
    target 7
    bw 47
  ]
  edge [
    source 7
    target 8
    bw 23
  ]
  edge [
    source 8
    target 9
    bw 38
  ]
  edge [
    source 9
    target 10
    bw 43
  ]
  edge [
    source 10
    target 11
    bw 18
  ]
]
