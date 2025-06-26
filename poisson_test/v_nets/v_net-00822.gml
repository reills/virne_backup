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
  id 822
  arrival_time 17062.625018059163
  lifetime 400.5766720707289
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 13
    gpu 4
    rom 10
  ]
  node [
    id 1
    label "1"
    cpu 4
    gpu 47
    rom 2
  ]
  node [
    id 2
    label "2"
    cpu 35
    gpu 47
    rom 40
  ]
  node [
    id 3
    label "3"
    cpu 38
    gpu 29
    rom 40
  ]
  node [
    id 4
    label "4"
    cpu 13
    gpu 2
    rom 5
  ]
  node [
    id 5
    label "5"
    cpu 12
    gpu 3
    rom 32
  ]
  node [
    id 6
    label "6"
    cpu 42
    gpu 40
    rom 16
  ]
  node [
    id 7
    label "7"
    cpu 32
    gpu 45
    rom 12
  ]
  node [
    id 8
    label "8"
    cpu 44
    gpu 27
    rom 12
  ]
  node [
    id 9
    label "9"
    cpu 42
    gpu 7
    rom 2
  ]
  node [
    id 10
    label "10"
    cpu 25
    gpu 30
    rom 7
  ]
  node [
    id 11
    label "11"
    cpu 38
    gpu 1
    rom 5
  ]
  node [
    id 12
    label "12"
    cpu 6
    gpu 13
    rom 16
  ]
  edge [
    source 0
    target 1
    bw 37
  ]
  edge [
    source 1
    target 2
    bw 24
  ]
  edge [
    source 2
    target 3
    bw 21
  ]
  edge [
    source 3
    target 4
    bw 9
  ]
  edge [
    source 4
    target 5
    bw 45
  ]
  edge [
    source 5
    target 6
    bw 26
  ]
  edge [
    source 6
    target 7
    bw 28
  ]
  edge [
    source 7
    target 8
    bw 14
  ]
  edge [
    source 8
    target 9
    bw 26
  ]
  edge [
    source 9
    target 10
    bw 19
  ]
  edge [
    source 10
    target 11
    bw 22
  ]
  edge [
    source 11
    target 12
    bw 15
  ]
]
