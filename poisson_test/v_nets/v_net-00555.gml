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
  id 555
  arrival_time 10506.516963986018
  lifetime 835.3245734324746
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 42
    gpu 2
    rom 42
  ]
  node [
    id 1
    label "1"
    cpu 15
    gpu 29
    rom 22
  ]
  node [
    id 2
    label "2"
    cpu 30
    gpu 34
    rom 28
  ]
  node [
    id 3
    label "3"
    cpu 7
    gpu 2
    rom 24
  ]
  node [
    id 4
    label "4"
    cpu 30
    gpu 17
    rom 21
  ]
  node [
    id 5
    label "5"
    cpu 20
    gpu 45
    rom 49
  ]
  node [
    id 6
    label "6"
    cpu 3
    gpu 5
    rom 12
  ]
  node [
    id 7
    label "7"
    cpu 24
    gpu 17
    rom 14
  ]
  node [
    id 8
    label "8"
    cpu 47
    gpu 12
    rom 32
  ]
  node [
    id 9
    label "9"
    cpu 16
    gpu 29
    rom 22
  ]
  node [
    id 10
    label "10"
    cpu 25
    gpu 38
    rom 20
  ]
  node [
    id 11
    label "11"
    cpu 28
    gpu 29
    rom 44
  ]
  node [
    id 12
    label "12"
    cpu 27
    gpu 7
    rom 42
  ]
  edge [
    source 0
    target 1
    bw 38
  ]
  edge [
    source 1
    target 2
    bw 50
  ]
  edge [
    source 2
    target 3
    bw 28
  ]
  edge [
    source 3
    target 4
    bw 6
  ]
  edge [
    source 4
    target 5
    bw 9
  ]
  edge [
    source 5
    target 6
    bw 4
  ]
  edge [
    source 6
    target 7
    bw 25
  ]
  edge [
    source 7
    target 8
    bw 13
  ]
  edge [
    source 8
    target 9
    bw 11
  ]
  edge [
    source 9
    target 10
    bw 29
  ]
  edge [
    source 10
    target 11
    bw 16
  ]
  edge [
    source 11
    target 12
    bw 46
  ]
]
