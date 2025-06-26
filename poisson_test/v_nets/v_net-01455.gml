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
  id 1455
  arrival_time 30609.161527720276
  lifetime 1288.187362894007
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 8
    gpu 25
    rom 23
  ]
  node [
    id 1
    label "1"
    cpu 32
    gpu 44
    rom 30
  ]
  node [
    id 2
    label "2"
    cpu 40
    gpu 13
    rom 33
  ]
  node [
    id 3
    label "3"
    cpu 26
    gpu 1
    rom 3
  ]
  node [
    id 4
    label "4"
    cpu 36
    gpu 2
    rom 42
  ]
  node [
    id 5
    label "5"
    cpu 31
    gpu 12
    rom 5
  ]
  node [
    id 6
    label "6"
    cpu 24
    gpu 19
    rom 2
  ]
  node [
    id 7
    label "7"
    cpu 30
    gpu 38
    rom 14
  ]
  node [
    id 8
    label "8"
    cpu 10
    gpu 43
    rom 27
  ]
  node [
    id 9
    label "9"
    cpu 15
    gpu 23
    rom 33
  ]
  edge [
    source 0
    target 1
    bw 50
  ]
  edge [
    source 1
    target 2
    bw 17
  ]
  edge [
    source 2
    target 3
    bw 22
  ]
  edge [
    source 3
    target 4
    bw 35
  ]
  edge [
    source 4
    target 5
    bw 15
  ]
  edge [
    source 5
    target 6
    bw 29
  ]
  edge [
    source 6
    target 7
    bw 11
  ]
  edge [
    source 7
    target 8
    bw 34
  ]
  edge [
    source 8
    target 9
    bw 46
  ]
]
