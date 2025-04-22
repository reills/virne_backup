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
  id 13
  arrival_time 320.97727766850556
  lifetime 31.36526645498138
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 3
    gpu 36
    rom 40
  ]
  node [
    id 1
    label "1"
    cpu 23
    gpu 31
    rom 6
  ]
  node [
    id 2
    label "2"
    cpu 11
    gpu 42
    rom 49
  ]
  node [
    id 3
    label "3"
    cpu 17
    gpu 48
    rom 7
  ]
  node [
    id 4
    label "4"
    cpu 31
    gpu 46
    rom 41
  ]
  node [
    id 5
    label "5"
    cpu 20
    gpu 9
    rom 21
  ]
  node [
    id 6
    label "6"
    cpu 35
    gpu 18
    rom 21
  ]
  node [
    id 7
    label "7"
    cpu 22
    gpu 44
    rom 23
  ]
  node [
    id 8
    label "8"
    cpu 41
    gpu 15
    rom 43
  ]
  node [
    id 9
    label "9"
    cpu 1
    gpu 33
    rom 48
  ]
  edge [
    source 0
    target 1
    bw 15
  ]
  edge [
    source 1
    target 2
    bw 4
  ]
  edge [
    source 2
    target 3
    bw 24
  ]
  edge [
    source 3
    target 4
    bw 21
  ]
  edge [
    source 4
    target 5
    bw 36
  ]
  edge [
    source 5
    target 6
    bw 12
  ]
  edge [
    source 6
    target 7
    bw 11
  ]
  edge [
    source 7
    target 8
    bw 25
  ]
  edge [
    source 8
    target 9
    bw 13
  ]
]
