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
  id 1274
  arrival_time 26713.80045401257
  lifetime 248.1088037991847
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 8
    gpu 14
    rom 11
  ]
  node [
    id 1
    label "1"
    cpu 44
    gpu 12
    rom 48
  ]
  node [
    id 2
    label "2"
    cpu 41
    gpu 24
    rom 46
  ]
  node [
    id 3
    label "3"
    cpu 26
    gpu 36
    rom 23
  ]
  node [
    id 4
    label "4"
    cpu 11
    gpu 8
    rom 50
  ]
  node [
    id 5
    label "5"
    cpu 15
    gpu 4
    rom 1
  ]
  node [
    id 6
    label "6"
    cpu 2
    gpu 0
    rom 4
  ]
  node [
    id 7
    label "7"
    cpu 22
    gpu 2
    rom 42
  ]
  node [
    id 8
    label "8"
    cpu 14
    gpu 28
    rom 49
  ]
  node [
    id 9
    label "9"
    cpu 25
    gpu 1
    rom 23
  ]
  node [
    id 10
    label "10"
    cpu 47
    gpu 21
    rom 24
  ]
  node [
    id 11
    label "11"
    cpu 12
    gpu 26
    rom 24
  ]
  edge [
    source 0
    target 1
    bw 45
  ]
  edge [
    source 1
    target 2
    bw 2
  ]
  edge [
    source 2
    target 3
    bw 45
  ]
  edge [
    source 3
    target 4
    bw 30
  ]
  edge [
    source 4
    target 5
    bw 22
  ]
  edge [
    source 5
    target 6
    bw 3
  ]
  edge [
    source 6
    target 7
    bw 49
  ]
  edge [
    source 7
    target 8
    bw 19
  ]
  edge [
    source 8
    target 9
    bw 39
  ]
  edge [
    source 9
    target 10
    bw 44
  ]
  edge [
    source 10
    target 11
    bw 27
  ]
]
