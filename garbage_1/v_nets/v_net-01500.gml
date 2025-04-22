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
  id 1500
  arrival_time 33351.99604891068
  lifetime 1437.6487502292032
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 23
    gpu 22
    rom 7
  ]
  node [
    id 1
    label "1"
    cpu 33
    gpu 43
    rom 4
  ]
  node [
    id 2
    label "2"
    cpu 15
    gpu 18
    rom 20
  ]
  node [
    id 3
    label "3"
    cpu 17
    gpu 49
    rom 7
  ]
  node [
    id 4
    label "4"
    cpu 23
    gpu 21
    rom 49
  ]
  node [
    id 5
    label "5"
    cpu 36
    gpu 5
    rom 3
  ]
  node [
    id 6
    label "6"
    cpu 39
    gpu 42
    rom 16
  ]
  node [
    id 7
    label "7"
    cpu 50
    gpu 42
    rom 12
  ]
  node [
    id 8
    label "8"
    cpu 26
    gpu 31
    rom 15
  ]
  node [
    id 9
    label "9"
    cpu 28
    gpu 2
    rom 16
  ]
  node [
    id 10
    label "10"
    cpu 45
    gpu 21
    rom 34
  ]
  node [
    id 11
    label "11"
    cpu 45
    gpu 7
    rom 35
  ]
  node [
    id 12
    label "12"
    cpu 30
    gpu 15
    rom 28
  ]
  node [
    id 13
    label "13"
    cpu 16
    gpu 50
    rom 34
  ]
  edge [
    source 0
    target 1
    bw 2
  ]
  edge [
    source 1
    target 2
    bw 36
  ]
  edge [
    source 2
    target 3
    bw 13
  ]
  edge [
    source 3
    target 4
    bw 40
  ]
  edge [
    source 4
    target 5
    bw 25
  ]
  edge [
    source 5
    target 6
    bw 23
  ]
  edge [
    source 6
    target 7
    bw 4
  ]
  edge [
    source 7
    target 8
    bw 3
  ]
  edge [
    source 8
    target 9
    bw 9
  ]
  edge [
    source 9
    target 10
    bw 23
  ]
  edge [
    source 10
    target 11
    bw 42
  ]
  edge [
    source 11
    target 12
    bw 21
  ]
  edge [
    source 12
    target 13
    bw 21
  ]
]
