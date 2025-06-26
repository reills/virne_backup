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
  id 1513
  arrival_time 33636.15175492535
  lifetime 138.20486364083877
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 34
    gpu 26
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 27
    gpu 6
    rom 3
  ]
  node [
    id 2
    label "2"
    cpu 30
    gpu 0
    rom 15
  ]
  node [
    id 3
    label "3"
    cpu 44
    gpu 6
    rom 30
  ]
  node [
    id 4
    label "4"
    cpu 38
    gpu 6
    rom 8
  ]
  node [
    id 5
    label "5"
    cpu 21
    gpu 49
    rom 29
  ]
  node [
    id 6
    label "6"
    cpu 37
    gpu 26
    rom 35
  ]
  node [
    id 7
    label "7"
    cpu 1
    gpu 20
    rom 28
  ]
  node [
    id 8
    label "8"
    cpu 17
    gpu 4
    rom 44
  ]
  node [
    id 9
    label "9"
    cpu 3
    gpu 22
    rom 19
  ]
  node [
    id 10
    label "10"
    cpu 2
    gpu 11
    rom 39
  ]
  node [
    id 11
    label "11"
    cpu 23
    gpu 16
    rom 22
  ]
  node [
    id 12
    label "12"
    cpu 12
    gpu 49
    rom 12
  ]
  edge [
    source 0
    target 1
    bw 36
  ]
  edge [
    source 1
    target 2
    bw 45
  ]
  edge [
    source 2
    target 3
    bw 13
  ]
  edge [
    source 3
    target 4
    bw 45
  ]
  edge [
    source 4
    target 5
    bw 12
  ]
  edge [
    source 5
    target 6
    bw 33
  ]
  edge [
    source 6
    target 7
    bw 48
  ]
  edge [
    source 7
    target 8
    bw 17
  ]
  edge [
    source 8
    target 9
    bw 32
  ]
  edge [
    source 9
    target 10
    bw 13
  ]
  edge [
    source 10
    target 11
    bw 30
  ]
  edge [
    source 11
    target 12
    bw 50
  ]
]
