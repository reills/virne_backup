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
  id 626
  arrival_time 12856.767362327986
  lifetime 1175.9159798853434
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 17
    gpu 28
    rom 3
  ]
  node [
    id 1
    label "1"
    cpu 27
    gpu 10
    rom 45
  ]
  node [
    id 2
    label "2"
    cpu 31
    gpu 34
    rom 1
  ]
  node [
    id 3
    label "3"
    cpu 50
    gpu 5
    rom 37
  ]
  node [
    id 4
    label "4"
    cpu 49
    gpu 11
    rom 39
  ]
  node [
    id 5
    label "5"
    cpu 23
    gpu 46
    rom 21
  ]
  node [
    id 6
    label "6"
    cpu 33
    gpu 35
    rom 37
  ]
  node [
    id 7
    label "7"
    cpu 1
    gpu 22
    rom 40
  ]
  node [
    id 8
    label "8"
    cpu 5
    gpu 24
    rom 44
  ]
  edge [
    source 0
    target 1
    bw 39
  ]
  edge [
    source 1
    target 2
    bw 49
  ]
  edge [
    source 2
    target 3
    bw 25
  ]
  edge [
    source 3
    target 4
    bw 48
  ]
  edge [
    source 4
    target 5
    bw 30
  ]
  edge [
    source 5
    target 6
    bw 8
  ]
  edge [
    source 6
    target 7
    bw 1
  ]
  edge [
    source 7
    target 8
    bw 35
  ]
]
