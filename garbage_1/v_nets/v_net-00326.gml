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
  id 326
  arrival_time 6246.44503120661
  lifetime 289.03713566649907
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 24
    gpu 42
    rom 25
  ]
  node [
    id 1
    label "1"
    cpu 49
    gpu 33
    rom 35
  ]
  node [
    id 2
    label "2"
    cpu 44
    gpu 40
    rom 29
  ]
  node [
    id 3
    label "3"
    cpu 36
    gpu 42
    rom 8
  ]
  node [
    id 4
    label "4"
    cpu 11
    gpu 37
    rom 4
  ]
  node [
    id 5
    label "5"
    cpu 2
    gpu 36
    rom 22
  ]
  node [
    id 6
    label "6"
    cpu 3
    gpu 50
    rom 45
  ]
  node [
    id 7
    label "7"
    cpu 13
    gpu 16
    rom 25
  ]
  node [
    id 8
    label "8"
    cpu 23
    gpu 11
    rom 26
  ]
  node [
    id 9
    label "9"
    cpu 35
    gpu 24
    rom 39
  ]
  edge [
    source 0
    target 1
    bw 24
  ]
  edge [
    source 1
    target 2
    bw 47
  ]
  edge [
    source 2
    target 3
    bw 0
  ]
  edge [
    source 3
    target 4
    bw 27
  ]
  edge [
    source 4
    target 5
    bw 5
  ]
  edge [
    source 5
    target 6
    bw 37
  ]
  edge [
    source 6
    target 7
    bw 7
  ]
  edge [
    source 7
    target 8
    bw 15
  ]
  edge [
    source 8
    target 9
    bw 40
  ]
]
