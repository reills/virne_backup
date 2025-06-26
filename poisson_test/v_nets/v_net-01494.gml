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
  id 1494
  arrival_time 33248.0134137288
  lifetime 1297.5198377797587
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 47
    gpu 49
    rom 7
  ]
  node [
    id 1
    label "1"
    cpu 46
    gpu 9
    rom 39
  ]
  node [
    id 2
    label "2"
    cpu 3
    gpu 32
    rom 33
  ]
  node [
    id 3
    label "3"
    cpu 36
    gpu 27
    rom 32
  ]
  node [
    id 4
    label "4"
    cpu 24
    gpu 8
    rom 17
  ]
  node [
    id 5
    label "5"
    cpu 11
    gpu 29
    rom 34
  ]
  node [
    id 6
    label "6"
    cpu 50
    gpu 29
    rom 14
  ]
  node [
    id 7
    label "7"
    cpu 23
    gpu 46
    rom 12
  ]
  node [
    id 8
    label "8"
    cpu 22
    gpu 31
    rom 4
  ]
  node [
    id 9
    label "9"
    cpu 5
    gpu 4
    rom 13
  ]
  node [
    id 10
    label "10"
    cpu 16
    gpu 35
    rom 30
  ]
  node [
    id 11
    label "11"
    cpu 2
    gpu 23
    rom 3
  ]
  edge [
    source 0
    target 1
    bw 5
  ]
  edge [
    source 1
    target 2
    bw 32
  ]
  edge [
    source 2
    target 3
    bw 3
  ]
  edge [
    source 3
    target 4
    bw 49
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
  edge [
    source 6
    target 7
    bw 15
  ]
  edge [
    source 7
    target 8
    bw 1
  ]
  edge [
    source 8
    target 9
    bw 38
  ]
  edge [
    source 9
    target 10
    bw 42
  ]
  edge [
    source 10
    target 11
    bw 2
  ]
]
