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
  id 1719
  arrival_time 38443.233427663145
  lifetime 6.7042212447397445
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 11
    gpu 32
    rom 12
  ]
  node [
    id 1
    label "1"
    cpu 44
    gpu 9
    rom 45
  ]
  node [
    id 2
    label "2"
    cpu 21
    gpu 23
    rom 32
  ]
  node [
    id 3
    label "3"
    cpu 19
    gpu 11
    rom 40
  ]
  node [
    id 4
    label "4"
    cpu 37
    gpu 27
    rom 0
  ]
  node [
    id 5
    label "5"
    cpu 50
    gpu 48
    rom 48
  ]
  node [
    id 6
    label "6"
    cpu 45
    gpu 26
    rom 11
  ]
  node [
    id 7
    label "7"
    cpu 5
    gpu 0
    rom 33
  ]
  node [
    id 8
    label "8"
    cpu 17
    gpu 32
    rom 21
  ]
  node [
    id 9
    label "9"
    cpu 25
    gpu 45
    rom 26
  ]
  node [
    id 10
    label "10"
    cpu 22
    gpu 11
    rom 37
  ]
  edge [
    source 0
    target 1
    bw 21
  ]
  edge [
    source 1
    target 2
    bw 38
  ]
  edge [
    source 2
    target 3
    bw 48
  ]
  edge [
    source 3
    target 4
    bw 50
  ]
  edge [
    source 4
    target 5
    bw 15
  ]
  edge [
    source 5
    target 6
    bw 8
  ]
  edge [
    source 6
    target 7
    bw 21
  ]
  edge [
    source 7
    target 8
    bw 26
  ]
  edge [
    source 8
    target 9
    bw 35
  ]
  edge [
    source 9
    target 10
    bw 14
  ]
]
