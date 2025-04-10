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
  id 1777
  arrival_time 39531.561469845066
  lifetime 1898.8548010356299
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 40
    gpu 50
    rom 41
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 28
    rom 6
  ]
  node [
    id 2
    label "2"
    cpu 7
    gpu 0
    rom 6
  ]
  node [
    id 3
    label "3"
    cpu 0
    gpu 36
    rom 19
  ]
  node [
    id 4
    label "4"
    cpu 44
    gpu 15
    rom 27
  ]
  node [
    id 5
    label "5"
    cpu 10
    gpu 44
    rom 24
  ]
  node [
    id 6
    label "6"
    cpu 34
    gpu 23
    rom 10
  ]
  node [
    id 7
    label "7"
    cpu 26
    gpu 12
    rom 32
  ]
  node [
    id 8
    label "8"
    cpu 22
    gpu 45
    rom 38
  ]
  node [
    id 9
    label "9"
    cpu 25
    gpu 2
    rom 2
  ]
  node [
    id 10
    label "10"
    cpu 27
    gpu 28
    rom 12
  ]
  node [
    id 11
    label "11"
    cpu 6
    gpu 8
    rom 20
  ]
  node [
    id 12
    label "12"
    cpu 4
    gpu 50
    rom 44
  ]
  edge [
    source 0
    target 1
    bw 1
  ]
  edge [
    source 1
    target 2
    bw 9
  ]
  edge [
    source 2
    target 3
    bw 4
  ]
  edge [
    source 3
    target 4
    bw 7
  ]
  edge [
    source 4
    target 5
    bw 11
  ]
  edge [
    source 5
    target 6
    bw 36
  ]
  edge [
    source 6
    target 7
    bw 3
  ]
  edge [
    source 7
    target 8
    bw 42
  ]
  edge [
    source 8
    target 9
    bw 16
  ]
  edge [
    source 9
    target 10
    bw 38
  ]
  edge [
    source 10
    target 11
    bw 16
  ]
  edge [
    source 11
    target 12
    bw 10
  ]
]
