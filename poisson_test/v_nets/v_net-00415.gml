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
  id 415
  arrival_time 8163.964091883076
  lifetime 2411.7196331779382
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 36
    gpu 27
    rom 18
  ]
  node [
    id 1
    label "1"
    cpu 8
    gpu 22
    rom 33
  ]
  node [
    id 2
    label "2"
    cpu 12
    gpu 42
    rom 7
  ]
  node [
    id 3
    label "3"
    cpu 12
    gpu 32
    rom 17
  ]
  node [
    id 4
    label "4"
    cpu 26
    gpu 12
    rom 36
  ]
  node [
    id 5
    label "5"
    cpu 46
    gpu 7
    rom 40
  ]
  node [
    id 6
    label "6"
    cpu 5
    gpu 32
    rom 2
  ]
  node [
    id 7
    label "7"
    cpu 10
    gpu 23
    rom 20
  ]
  node [
    id 8
    label "8"
    cpu 7
    gpu 1
    rom 38
  ]
  node [
    id 9
    label "9"
    cpu 45
    gpu 26
    rom 48
  ]
  node [
    id 10
    label "10"
    cpu 25
    gpu 4
    rom 28
  ]
  node [
    id 11
    label "11"
    cpu 7
    gpu 23
    rom 48
  ]
  node [
    id 12
    label "12"
    cpu 16
    gpu 5
    rom 24
  ]
  node [
    id 13
    label "13"
    cpu 1
    gpu 4
    rom 44
  ]
  node [
    id 14
    label "14"
    cpu 31
    gpu 7
    rom 6
  ]
  edge [
    source 0
    target 1
    bw 45
  ]
  edge [
    source 1
    target 2
    bw 31
  ]
  edge [
    source 2
    target 3
    bw 28
  ]
  edge [
    source 3
    target 4
    bw 36
  ]
  edge [
    source 4
    target 5
    bw 35
  ]
  edge [
    source 5
    target 6
    bw 33
  ]
  edge [
    source 6
    target 7
    bw 39
  ]
  edge [
    source 7
    target 8
    bw 32
  ]
  edge [
    source 8
    target 9
    bw 20
  ]
  edge [
    source 9
    target 10
    bw 47
  ]
  edge [
    source 10
    target 11
    bw 11
  ]
  edge [
    source 11
    target 12
    bw 17
  ]
  edge [
    source 12
    target 13
    bw 17
  ]
  edge [
    source 13
    target 14
    bw 42
  ]
]
