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
  id 1854
  arrival_time 40873.59624500592
  lifetime 1591.280419070921
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 31
    gpu 29
    rom 42
  ]
  node [
    id 1
    label "1"
    cpu 19
    gpu 24
    rom 16
  ]
  node [
    id 2
    label "2"
    cpu 14
    gpu 30
    rom 27
  ]
  node [
    id 3
    label "3"
    cpu 14
    gpu 44
    rom 44
  ]
  node [
    id 4
    label "4"
    cpu 4
    gpu 11
    rom 5
  ]
  node [
    id 5
    label "5"
    cpu 3
    gpu 27
    rom 15
  ]
  node [
    id 6
    label "6"
    cpu 46
    gpu 25
    rom 20
  ]
  node [
    id 7
    label "7"
    cpu 37
    gpu 10
    rom 18
  ]
  node [
    id 8
    label "8"
    cpu 47
    gpu 40
    rom 27
  ]
  node [
    id 9
    label "9"
    cpu 46
    gpu 46
    rom 22
  ]
  node [
    id 10
    label "10"
    cpu 39
    gpu 24
    rom 1
  ]
  node [
    id 11
    label "11"
    cpu 8
    gpu 30
    rom 28
  ]
  node [
    id 12
    label "12"
    cpu 17
    gpu 28
    rom 44
  ]
  edge [
    source 0
    target 1
    bw 41
  ]
  edge [
    source 1
    target 2
    bw 47
  ]
  edge [
    source 2
    target 3
    bw 21
  ]
  edge [
    source 3
    target 4
    bw 27
  ]
  edge [
    source 4
    target 5
    bw 26
  ]
  edge [
    source 5
    target 6
    bw 50
  ]
  edge [
    source 6
    target 7
    bw 10
  ]
  edge [
    source 7
    target 8
    bw 47
  ]
  edge [
    source 8
    target 9
    bw 47
  ]
  edge [
    source 9
    target 10
    bw 29
  ]
  edge [
    source 10
    target 11
    bw 32
  ]
  edge [
    source 11
    target 12
    bw 6
  ]
]
