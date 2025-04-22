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
  id 225
  arrival_time 4109.796992595975
  lifetime 1071.7563316117844
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 6
    gpu 30
    rom 31
  ]
  node [
    id 1
    label "1"
    cpu 31
    gpu 42
    rom 23
  ]
  node [
    id 2
    label "2"
    cpu 0
    gpu 25
    rom 10
  ]
  node [
    id 3
    label "3"
    cpu 15
    gpu 22
    rom 20
  ]
  node [
    id 4
    label "4"
    cpu 20
    gpu 18
    rom 26
  ]
  node [
    id 5
    label "5"
    cpu 24
    gpu 45
    rom 49
  ]
  node [
    id 6
    label "6"
    cpu 44
    gpu 26
    rom 39
  ]
  node [
    id 7
    label "7"
    cpu 38
    gpu 39
    rom 6
  ]
  node [
    id 8
    label "8"
    cpu 3
    gpu 10
    rom 30
  ]
  node [
    id 9
    label "9"
    cpu 30
    gpu 2
    rom 29
  ]
  node [
    id 10
    label "10"
    cpu 17
    gpu 3
    rom 22
  ]
  edge [
    source 0
    target 1
    bw 38
  ]
  edge [
    source 1
    target 2
    bw 21
  ]
  edge [
    source 2
    target 3
    bw 20
  ]
  edge [
    source 3
    target 4
    bw 7
  ]
  edge [
    source 4
    target 5
    bw 49
  ]
  edge [
    source 5
    target 6
    bw 7
  ]
  edge [
    source 6
    target 7
    bw 36
  ]
  edge [
    source 7
    target 8
    bw 7
  ]
  edge [
    source 8
    target 9
    bw 19
  ]
  edge [
    source 9
    target 10
    bw 8
  ]
]
