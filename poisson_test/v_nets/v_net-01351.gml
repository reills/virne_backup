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
  id 1351
  arrival_time 28609.934284500076
  lifetime 862.4696869832911
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 42
    gpu 39
    rom 14
  ]
  node [
    id 1
    label "1"
    cpu 0
    gpu 12
    rom 50
  ]
  node [
    id 2
    label "2"
    cpu 3
    gpu 25
    rom 33
  ]
  node [
    id 3
    label "3"
    cpu 3
    gpu 12
    rom 15
  ]
  node [
    id 4
    label "4"
    cpu 28
    gpu 23
    rom 20
  ]
  node [
    id 5
    label "5"
    cpu 46
    gpu 1
    rom 12
  ]
  node [
    id 6
    label "6"
    cpu 47
    gpu 9
    rom 41
  ]
  node [
    id 7
    label "7"
    cpu 47
    gpu 14
    rom 17
  ]
  node [
    id 8
    label "8"
    cpu 34
    gpu 49
    rom 19
  ]
  node [
    id 9
    label "9"
    cpu 18
    gpu 9
    rom 36
  ]
  node [
    id 10
    label "10"
    cpu 42
    gpu 34
    rom 2
  ]
  node [
    id 11
    label "11"
    cpu 48
    gpu 41
    rom 0
  ]
  node [
    id 12
    label "12"
    cpu 36
    gpu 20
    rom 35
  ]
  node [
    id 13
    label "13"
    cpu 17
    gpu 14
    rom 12
  ]
  node [
    id 14
    label "14"
    cpu 29
    gpu 11
    rom 33
  ]
  edge [
    source 0
    target 1
    bw 11
  ]
  edge [
    source 1
    target 2
    bw 1
  ]
  edge [
    source 2
    target 3
    bw 47
  ]
  edge [
    source 3
    target 4
    bw 2
  ]
  edge [
    source 4
    target 5
    bw 12
  ]
  edge [
    source 5
    target 6
    bw 31
  ]
  edge [
    source 6
    target 7
    bw 20
  ]
  edge [
    source 7
    target 8
    bw 10
  ]
  edge [
    source 8
    target 9
    bw 15
  ]
  edge [
    source 9
    target 10
    bw 45
  ]
  edge [
    source 10
    target 11
    bw 17
  ]
  edge [
    source 11
    target 12
    bw 22
  ]
  edge [
    source 12
    target 13
    bw 8
  ]
  edge [
    source 13
    target 14
    bw 32
  ]
]
