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
  id 259
  arrival_time 4926.5582346648325
  lifetime 229.79914847395338
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 43
    gpu 40
    rom 45
  ]
  node [
    id 1
    label "1"
    cpu 3
    gpu 26
    rom 16
  ]
  node [
    id 2
    label "2"
    cpu 13
    gpu 0
    rom 14
  ]
  node [
    id 3
    label "3"
    cpu 41
    gpu 47
    rom 25
  ]
  node [
    id 4
    label "4"
    cpu 17
    gpu 15
    rom 9
  ]
  node [
    id 5
    label "5"
    cpu 29
    gpu 13
    rom 39
  ]
  node [
    id 6
    label "6"
    cpu 30
    gpu 36
    rom 49
  ]
  node [
    id 7
    label "7"
    cpu 39
    gpu 17
    rom 0
  ]
  node [
    id 8
    label "8"
    cpu 6
    gpu 34
    rom 31
  ]
  node [
    id 9
    label "9"
    cpu 19
    gpu 4
    rom 14
  ]
  node [
    id 10
    label "10"
    cpu 31
    gpu 19
    rom 23
  ]
  node [
    id 11
    label "11"
    cpu 43
    gpu 32
    rom 15
  ]
  node [
    id 12
    label "12"
    cpu 24
    gpu 8
    rom 9
  ]
  edge [
    source 0
    target 1
    bw 43
  ]
  edge [
    source 1
    target 2
    bw 29
  ]
  edge [
    source 2
    target 3
    bw 43
  ]
  edge [
    source 3
    target 4
    bw 12
  ]
  edge [
    source 4
    target 5
    bw 12
  ]
  edge [
    source 5
    target 6
    bw 47
  ]
  edge [
    source 6
    target 7
    bw 28
  ]
  edge [
    source 7
    target 8
    bw 11
  ]
  edge [
    source 8
    target 9
    bw 29
  ]
  edge [
    source 9
    target 10
    bw 4
  ]
  edge [
    source 10
    target 11
    bw 32
  ]
  edge [
    source 11
    target 12
    bw 47
  ]
]
