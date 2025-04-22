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
  id 172
  arrival_time 3252.446368043351
  lifetime 2718.948610933909
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 26
    gpu 36
    rom 17
  ]
  node [
    id 1
    label "1"
    cpu 13
    gpu 18
    rom 4
  ]
  node [
    id 2
    label "2"
    cpu 30
    gpu 30
    rom 33
  ]
  node [
    id 3
    label "3"
    cpu 31
    gpu 17
    rom 19
  ]
  node [
    id 4
    label "4"
    cpu 1
    gpu 24
    rom 18
  ]
  node [
    id 5
    label "5"
    cpu 11
    gpu 9
    rom 1
  ]
  node [
    id 6
    label "6"
    cpu 38
    gpu 48
    rom 16
  ]
  node [
    id 7
    label "7"
    cpu 27
    gpu 8
    rom 46
  ]
  node [
    id 8
    label "8"
    cpu 50
    gpu 36
    rom 42
  ]
  node [
    id 9
    label "9"
    cpu 5
    gpu 27
    rom 23
  ]
  node [
    id 10
    label "10"
    cpu 30
    gpu 6
    rom 47
  ]
  node [
    id 11
    label "11"
    cpu 40
    gpu 42
    rom 25
  ]
  edge [
    source 0
    target 1
    bw 39
  ]
  edge [
    source 1
    target 2
    bw 12
  ]
  edge [
    source 2
    target 3
    bw 19
  ]
  edge [
    source 3
    target 4
    bw 14
  ]
  edge [
    source 4
    target 5
    bw 3
  ]
  edge [
    source 5
    target 6
    bw 7
  ]
  edge [
    source 6
    target 7
    bw 50
  ]
  edge [
    source 7
    target 8
    bw 50
  ]
  edge [
    source 8
    target 9
    bw 8
  ]
  edge [
    source 9
    target 10
    bw 12
  ]
  edge [
    source 10
    target 11
    bw 23
  ]
]
