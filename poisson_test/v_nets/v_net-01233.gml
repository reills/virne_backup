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
  id 1233
  arrival_time 25443.294482590416
  lifetime 602.1370992704595
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 46
    gpu 45
    rom 14
  ]
  node [
    id 1
    label "1"
    cpu 43
    gpu 36
    rom 33
  ]
  node [
    id 2
    label "2"
    cpu 35
    gpu 25
    rom 49
  ]
  node [
    id 3
    label "3"
    cpu 49
    gpu 46
    rom 50
  ]
  node [
    id 4
    label "4"
    cpu 7
    gpu 10
    rom 7
  ]
  node [
    id 5
    label "5"
    cpu 12
    gpu 47
    rom 30
  ]
  node [
    id 6
    label "6"
    cpu 33
    gpu 37
    rom 14
  ]
  node [
    id 7
    label "7"
    cpu 31
    gpu 40
    rom 13
  ]
  node [
    id 8
    label "8"
    cpu 11
    gpu 6
    rom 15
  ]
  node [
    id 9
    label "9"
    cpu 27
    gpu 35
    rom 21
  ]
  node [
    id 10
    label "10"
    cpu 49
    gpu 50
    rom 44
  ]
  node [
    id 11
    label "11"
    cpu 26
    gpu 30
    rom 16
  ]
  node [
    id 12
    label "12"
    cpu 47
    gpu 19
    rom 38
  ]
  node [
    id 13
    label "13"
    cpu 42
    gpu 22
    rom 49
  ]
  node [
    id 14
    label "14"
    cpu 9
    gpu 34
    rom 18
  ]
  edge [
    source 0
    target 1
    bw 12
  ]
  edge [
    source 1
    target 2
    bw 21
  ]
  edge [
    source 2
    target 3
    bw 43
  ]
  edge [
    source 3
    target 4
    bw 33
  ]
  edge [
    source 4
    target 5
    bw 38
  ]
  edge [
    source 5
    target 6
    bw 23
  ]
  edge [
    source 6
    target 7
    bw 25
  ]
  edge [
    source 7
    target 8
    bw 9
  ]
  edge [
    source 8
    target 9
    bw 44
  ]
  edge [
    source 9
    target 10
    bw 27
  ]
  edge [
    source 10
    target 11
    bw 18
  ]
  edge [
    source 11
    target 12
    bw 3
  ]
  edge [
    source 12
    target 13
    bw 18
  ]
  edge [
    source 13
    target 14
    bw 46
  ]
]
