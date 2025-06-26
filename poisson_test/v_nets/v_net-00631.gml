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
  id 631
  arrival_time 12938.520012942841
  lifetime 659.4514545689535
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 43
    gpu 27
    rom 18
  ]
  node [
    id 1
    label "1"
    cpu 31
    gpu 28
    rom 9
  ]
  node [
    id 2
    label "2"
    cpu 25
    gpu 32
    rom 21
  ]
  node [
    id 3
    label "3"
    cpu 1
    gpu 22
    rom 11
  ]
  node [
    id 4
    label "4"
    cpu 26
    gpu 13
    rom 28
  ]
  node [
    id 5
    label "5"
    cpu 31
    gpu 23
    rom 22
  ]
  node [
    id 6
    label "6"
    cpu 10
    gpu 20
    rom 7
  ]
  node [
    id 7
    label "7"
    cpu 43
    gpu 44
    rom 6
  ]
  node [
    id 8
    label "8"
    cpu 4
    gpu 2
    rom 23
  ]
  node [
    id 9
    label "9"
    cpu 34
    gpu 34
    rom 13
  ]
  node [
    id 10
    label "10"
    cpu 14
    gpu 14
    rom 1
  ]
  node [
    id 11
    label "11"
    cpu 24
    gpu 6
    rom 4
  ]
  node [
    id 12
    label "12"
    cpu 28
    gpu 33
    rom 20
  ]
  node [
    id 13
    label "13"
    cpu 6
    gpu 3
    rom 9
  ]
  node [
    id 14
    label "14"
    cpu 10
    gpu 49
    rom 50
  ]
  edge [
    source 0
    target 1
    bw 36
  ]
  edge [
    source 1
    target 2
    bw 10
  ]
  edge [
    source 2
    target 3
    bw 24
  ]
  edge [
    source 3
    target 4
    bw 40
  ]
  edge [
    source 4
    target 5
    bw 1
  ]
  edge [
    source 5
    target 6
    bw 50
  ]
  edge [
    source 6
    target 7
    bw 26
  ]
  edge [
    source 7
    target 8
    bw 40
  ]
  edge [
    source 8
    target 9
    bw 37
  ]
  edge [
    source 9
    target 10
    bw 3
  ]
  edge [
    source 10
    target 11
    bw 0
  ]
  edge [
    source 11
    target 12
    bw 32
  ]
  edge [
    source 12
    target 13
    bw 33
  ]
  edge [
    source 13
    target 14
    bw 25
  ]
]
